#include "pendingconnection.h"

#include <QDataStream>

namespace Internal
{
struct Message
{
    //TODO add json obj
    uint32_t command;
    struct json {};
    json payload;
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

    switch (msg.command)
    {

    }
}
