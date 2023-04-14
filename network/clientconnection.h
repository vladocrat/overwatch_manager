#pragma once

#include <QByteArray>
#include <QObject>
#include <QHostAddress>

#include "connection.h"

class ClientConnection final : public Connection
{
    Q_OBJECT;
public:
    static ClientConnection* instance()
    {
        static ClientConnection cc;
        return &cc;
    }

    void connectToHost();

    void setAddress(const QHostAddress&);
    void setPort(uint32_t);
    const QHostAddress address() const {return m_address;}
    const uint32_t port() const {return m_port;}

private:
    ClientConnection();
    ClientConnection(const ClientConnection&) = delete;
    ClientConnection(ClientConnection&&) = delete;
    ClientConnection operator=(const ClientConnection&) = delete;
    ClientConnection operator=(ClientConnection&&) = delete;

    void handleData();

    QHostAddress m_address;
    uint32_t m_port;
};
