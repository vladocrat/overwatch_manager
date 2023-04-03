#pragma once

#include <QTcpServer>
#include <QObject>
#include <QList>

class TcpServer final : public QTcpServer
{
    Q_OBJECT
public:
    static TcpServer* instance()
    {
        static TcpServer server;
        return &server;
    }

    void listen();
    void setAddress(const QHostAddress&);
    void setPort(int);
    const QHostAddress address() const { return m_address; }
    const int port() const { return m_port; }

protected:
    void incomingConnection(qintptr handle) override;

private:
    TcpServer() = default;
    TcpServer(const TcpServer&) = delete;
    TcpServer(TcpServer&&) = delete;
    TcpServer operator=(const TcpServer&) = delete;
    TcpServer operator=(TcpServer&&) = delete;
    ~TcpServer();

    QHostAddress m_address = QHostAddress::Any;
    int m_port = 0;
};

