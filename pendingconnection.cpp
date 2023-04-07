#include "pendingconnection.h"

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
    msg.command = connection->readCommand(stream);

    return msg;
}
} // Internal

PendingConnection::PendingConnection()
{
    connect(socket(), &QTcpSocket::readyRead, this, &PendingConnection::handleData);
}

void PendingConnection::handleData()
{
    auto msg = Internal::readMessage(this);
    QByteArray arr;
    QDataStream s(&arr, QIODevice::WriteOnly);
    s << msg.command;
    send(0, arr);

    switch (msg.command)
    {

    }
}
