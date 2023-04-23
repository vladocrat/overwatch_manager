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
    int m_currentFPS;
    int m_cacheCount;
    QVector<qint64> m_times;
};
