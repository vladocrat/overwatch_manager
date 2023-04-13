#pragma once

#include <QByteArray>
#include <QObject>

#include "connection.h"

class ClientConnection : public Connection
{
    Q_OBJECT;
public:
    ClientConnection();

private:
    void handleData();
};
