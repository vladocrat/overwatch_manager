#pragma once

#include <QObject>
#include <QClipboard>
#include <QQmlEngine>

namespace QmlHelper
{

class ClipboardProxy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text NOTIFY textChanged)
public:
    ClipboardProxy();
    ~ClipboardProxy() noexcept;

    QString text() const;

    static void registerType()
    {
        qmlRegisterType<ClipboardProxy>("Clipboard", 1, 0, "Clipboard");
    }

signals:
    void textChanged();

private:
    QClipboard* m_clipboard;
};

} // QmlHelper
