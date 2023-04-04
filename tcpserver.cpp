#include "tcpserver.h"

#include <QDebug>

TcpServer::~TcpServer()
{

}

const QString TcpServer::toString() const
{
    return QString()
            .append("address=")
            .append(m_address.toString())
            .append(" port=")
            .append(QString::number(m_port));
}

void TcpServer::listen()
{
    if (!QTcpServer::listen(m_address, m_port))
    {
        qDebug() << "failed to listen on: " << toString();
    }
}

void TcpServer::setAddress(const QHostAddress& address)
{
    m_address = address;
}

void TcpServer::setPort(int port)
{
    m_port = port;
}

void TcpServer::incomingConnection(qintptr handle)
{
    auto pendingConnection = new PendingConnection;
    pendingConnection->socket()->setSocketDescriptor(handle);

    connect(pendingConnection->socket(), &QTcpSocket::disconnected, [this, pendingConnection]()
    {
        m_pendingConnections.removeOne(pendingConnection);
    });

    m_pendingConnections.append(pendingConnection);
}
