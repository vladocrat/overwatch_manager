#pragma once

#include <QQuickPaintedItem>

class FPSText: public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(int fps READ fps NOTIFY fpsChanged)
public:

    static void registerType()
    {
        qmlRegisterType<FPSText>("FPSText", 1, 0, "FPSText");
    }

    FPSText(QQuickItem* parent = 0);

    Q_INVOKABLE int fps() const;

    void paint(QPainter*);

signals:
    void fpsChanged(int);

private:
    void recalculateFPS();
    int _currentFPS;
    int _cacheCount;
    QVector<qint64> _times;
};
