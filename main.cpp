#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "configurer.h"
#include "clientconnection.h"

#define client ClientConnection::instance()

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    auto configurer = Config::Configurer("settings.ini");
    auto networkConfig = configurer.configureNetwork();
    client->setAddress(networkConfig.address());
    client->setPort(networkConfig.port());
    //client->connectToHost();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
