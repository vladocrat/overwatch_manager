#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QList>
#include <QQmlProperty>
#include <QQuickWindow>

#include "configurer.h"
#include "clientconnection.h"

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
} // Internal

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QUrl authenticationWrapper("qrc:/AuthenticationWrapper.qml");
    engine.load(authenticationWrapper);

    const QUrl url(QStringLiteral("qrc:/main.qml"));

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
        return -1;
    }

    auto authWindow = qobject_cast<QQuickWindow*>(objects.at(0));

    if (!authWindow)
    {
        qDebug() << "auth window is nullptr";
        return -1;
    }

    QObject::connect(authWindow, &QQuickWindow::visibilityChanged, &app, [authWindow, objects]()
    {
        if (authWindow->isVisible())
        {
            qDebug() << "is visible";
            return;
        }

        authWindow->setProperty("visible", QVariant(false));
        auto mainWindow = qobject_cast<QQuickWindow*>(objects.at(1));
        mainWindow->setProperty("visible", QVariant(true));
    });

    return app.exec();
}
