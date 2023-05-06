#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QList>
#include <QQmlProperty>
#include <QQuickWindow>

#include "configurer.h"
#include "clientconnection.h"
#include "fpstext.h"
#include "clipboardproxy.h"
#include "simplebalancer.h"

#define client ClientConnection::instance()
#define configurer Config::Configurer("settings.ini")

namespace Internal
{

void initClient()
{
    auto networkConfig = configurer.configureNetwork();
    client->setAddress(networkConfig.address());
    client->setPort(networkConfig.port());
    client->connectToHost();
}

void registerTypes()
{
    qmlRegisterSingletonType(QUrl("qrc:/qml/ApplicationSettings.qml"), "ApplicationSettings", 1, 0, "AppSettings");

    QmlHelper::ClipboardProxy::registerType();
    FPSText::registerType();
}

void loadScreens(QQmlApplicationEngine& engine, QGuiApplication& app)
{
    const QUrl authenticationWrapper("qrc:/qml/AuthenticationWrapper.qml");
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    engine.addImportPath("qrc:/qml");
    engine.load(authenticationWrapper);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app,
                     [url](QObject *obj, const QUrl &objUrl)
    {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection);

    engine.load(url);

    auto objects = engine.rootObjects();

    if (objects.size() <= 0)
    {
        qDebug() << "engine has no children";
        return;
    }

    auto authWindow = qobject_cast<QQuickWindow*>(objects.at(0));

    if (!authWindow)
    {
        qDebug() << "auth window is nullptr";
        return;
    }

    QObject::connect(authWindow, &QQuickWindow::visibilityChanged, &app, [authWindow, objects]()
    {
        if (authWindow->isVisible())
        {
            return;
        }

        authWindow->setProperty("visible", QVariant(false));
        auto mainWindow = qobject_cast<QQuickWindow*>(objects.at(1));

        if (!mainWindow)
        {
            qDebug() << "main window is nullptr";
            exit(-1);
        }

        //mainWindow->setProperty("visible", QVariant(true));
    });

}

} // Internal

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    Internal::registerTypes();

    QQmlApplicationEngine engine;

    QVector<Balancer::Player> blue = {
        {
            "sherlock",
            {
                {4000, Balancer::Role::Type::Support},
                {3000, Balancer::Role::Type::Damage},
                {2000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Support
        },
        {
            "tacocat",
            {
                {3000, Balancer::Role::Type::Support},
                {3000, Balancer::Role::Type::Damage},
                {3000, Balancer::Role::Type::Tank}
            },
            Balancer::Role::Type::Tank
        },
        {
            "tooslow",
            {
                {1234, Balancer::Role::Type::Support},
                {2500, Balancer::Role::Type::Damage},
                {3450, Balancer::Role::Type::Tank}
            },
            Balancer::Role::Type::Damage
        },
        {
            "jakal",
            {
                {2500, Balancer::Role::Type::Support},
                {2500, Balancer::Role::Type::Damage},
                {2500, Balancer::Role::Type::Tank}
            },
            Balancer::Role::Type::Damage
        },
        {
            "jason",
            {
                {3400, Balancer::Role::Type::Support},
                {3400, Balancer::Role::Type::Damage},
                {3400, Balancer::Role::Type::Tank}
            },
            Balancer::Role::Type::Support
        },
        {
            "a",
            {
                {3000, Balancer::Role::Type::Support},
                {3000, Balancer::Role::Type::Damage},
                {2000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Tank
        },
        {
            "b",
            {
                {4000, Balancer::Role::Type::Support},
                {4000, Balancer::Role::Type::Damage},
                {4000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Damage
        },
        {
            "c",
            {
                {3500, Balancer::Role::Type::Support},
                {3500, Balancer::Role::Type::Damage},
                {3400, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Damage
        },
        {
            "d",
            {
                {3000, Balancer::Role::Type::Support},
                {3000, Balancer::Role::Type::Damage},
                {3000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Support
        },
        {
            "e",
            {
                {3500, Balancer::Role::Type::Support},
                {3500, Balancer::Role::Type::Damage},
                {3500, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Support
        }
    };

    /*QVector<Balancer::Player> red = {
        {
            "a",
            {
                {3000, Balancer::Role::Type::Support},
                {3000, Balancer::Role::Type::Damage},
                {2000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Tank
        },
        {
            "b",
            {
                {4000, Balancer::Role::Type::Support},
                {4000, Balancer::Role::Type::Damage},
                {4000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Damage
        },
        {
            "c",
            {
                {3500, Balancer::Role::Type::Support},
                {3500, Balancer::Role::Type::Damage},
                {3400, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Damage
        },
        {
            "d",
            {
                {3000, Balancer::Role::Type::Support},
                {3000, Balancer::Role::Type::Damage},
                {3000, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Support
        },
        {
            "e",
            {
                {3500, Balancer::Role::Type::Support},
                {3500, Balancer::Role::Type::Damage},
                {3500, Balancer::Role::Type::Tank},
            },
            Balancer::Role::Type::Support
        }
    };
    */

    Balancer::SimpleBalancer balancer;
    auto teams = balancer.balance(blue);

    auto printPlayers = [](const Balancer::Team& t)
    {
        auto players = t.players();

        for (const auto& player: players)
        {
            qDebug() << player.toString() << "\n";
        }
    };

    auto printRoles = [](const Balancer::Team& t)
    {
        auto players = t.players();

        for (const auto& player: players)
        {
            qDebug() << player.findPreference().toString() << "\n";
        }
    };


    printRoles(teams.red);
    qDebug() << " ----------- ";
    printRoles(teams.blue);

    return app.exec();
}
