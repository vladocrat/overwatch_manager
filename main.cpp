#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>

#include "configurer.h"
#include "clientconnection.h"

#define client ClientConnection::instance()
#define configurer Config::Configurer("settings.ini")

void initClient()
{
    auto networkConfig = configurer.configureNetwork();
    client->setAddress(networkConfig.address());
    client->setPort(networkConfig.port());
    client->connectToHost();
}

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QUrl authenticationWrapper("qrc:/AuthenticationWrapper.qml");
    engine.load(authenticationWrapper);

//    QQuickView authenticationPopup;
//    authenticationPopup.setSource(QUrl("qrc:/AuthenticationWrapper.qml"));
//    authenticationPopup.show();

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    //engine.load(url);
    return app.exec();
}
