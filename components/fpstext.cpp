#include "fpstext.h"

#include <QDateTime>
#include <QPainter>
#include <QQmlEngine>

FPSText::FPSText(QQuickItem* parent): QQuickPaintedItem(parent), m_currentFPS(0), m_cacheCount(0)
{
    m_times.clear();
    setFlag(QQuickItem::ItemHasContents);
}

void FPSText::recalculateFPS()
{
    qint64 currentTime = QDateTime::currentDateTime().toMSecsSinceEpoch();
    m_times.push_back(currentTime);

    while (m_times[0] < currentTime - 1000) {
        m_times.pop_front();
    }

    int currentCount = m_times.length();
    m_currentFPS = (currentCount + m_cacheCount) / 2;

    if (currentCount != m_cacheCount)
        emit fpsChanged(m_currentFPS);

    m_cacheCount = currentCount;
}

int FPSText::fps()const
{
    return m_currentFPS;
}

void FPSText::paint(QPainter* painter)
{
    recalculateFPS();
    QBrush brush(Qt::transparent);

    painter->setBrush(brush);
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);
    painter->drawRoundedRect(0, 0, boundingRect().width(), boundingRect().height(), 0, 0);
    update();
}
