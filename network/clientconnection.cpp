#include "clientconnection.h"
#include "protocol.h"

#include <QDataStream>

namespace Internal
{

struct Message
{
    uint32_t command;
    QByteArray payload;
};

Message readMessage(Connection* connection)
{
    QByteArray data;
    connection->readUserData(data);
    QDataStream stream(data);
    Message msg;
    qDebug() << data;
    qDebug() << data.size();
    stream >> msg.command;
    stream >> msg.payload;

    return msg;
}

} // Internal

void ClientConnection::connectToHost()
{
    socket()->connectToHost(m_address, m_port);

    if (!socket()->waitForConnected())
    {
        qDebug() << "failed to connect to host";
    }
}

void ClientConnection::setAddress(const QHostAddress& addr)
{
    m_address = addr;
}

void ClientConnection::setPort(uint32_t port)
{
    m_port = port;
}

ClientConnection::ClientConnection()
{
    connect(socket(), &QTcpSocket::readyRead, this, &ClientConnection::handleData);
}

void ClientConnection::handleData()
{
    auto msg = Internal::readMessage(this);
    qDebug() << "message command: " << msg.command;
    QDataStream stream(msg.payload);

    switch (msg.command)
    {
    case Protocol::Bot::B_Hello:
    {
        QString str;
        int i;
        stream >> str;
        stream >> i;
        qDebug() << "stream status" << stream.status();
        qDebug() << str;
        break;
    }
    default:
        break;
    }
}
