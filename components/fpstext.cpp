#include "fpstext.h"

#include <QDateTime>
#include <QPainter>
#include <QQmlEngine>

FPSText::FPSText(QQuickItem *parent): QQuickPaintedItem(parent), _currentFPS(0), _cacheCount(0)
{
    _times.clear();
    setFlag(QQuickItem::ItemHasContents);
}

void FPSText::recalculateFPS()
{
    qint64 currentTime = QDateTime::currentDateTime().toMSecsSinceEpoch();
    _times.push_back(currentTime);

    while (_times[0] < currentTime - 1000) {
        _times.pop_front();
    }

    int currentCount = _times.length();
    _currentFPS = (currentCount + _cacheCount) / 2;

    if (currentCount != _cacheCount)
        emit fpsChanged(_currentFPS);

    _cacheCount = currentCount;
}

int FPSText::fps()const
{
    return _currentFPS;
}

void FPSText::paint(QPainter *painter)
{
    recalculateFPS();
    QBrush brush(Qt::transparent);

    painter->setBrush(brush);
    painter->setPen(Qt::NoPen);
    painter->setRenderHint(QPainter::Antialiasing);
    painter->drawText(QPoint{0, 0}, QString::number(_currentFPS));
    painter->drawRoundedRect(0, 0, boundingRect().width(), boundingRect().height(), 0, 0);
    update();
}
