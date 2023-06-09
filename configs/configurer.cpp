#include "configurer.h"

#include <exception>

namespace Config
{

Configurer::Configurer(const QString& filePath):
    m_filePath(filePath)
{

}

NetworkConfig Configurer::configureNetwork()
{
    QSettings settings(m_filePath, QSettings::IniFormat);
    settings.beginGroup("Network");
    auto address = settings.value("address").toString();
    auto port = settings.value("port").toUInt();
    settings.endGroup();
    return NetworkConfig(QHostAddress(address), port);
}


} // Config
