#include "clipboardproxy.h"

#include <QGuiApplication>

namespace QmlHelper
{

ClipboardProxy::ClipboardProxy()
{
    m_clipboard = QGuiApplication::clipboard();
    connect(m_clipboard, &QClipboard::dataChanged, this, &ClipboardProxy::textChanged);
}

ClipboardProxy::~ClipboardProxy() noexcept
{
    if (m_clipboard)
        m_clipboard->deleteLater();
}

QString ClipboardProxy::text() const
{
    return m_clipboard->text();
}

} // QmlHelper
