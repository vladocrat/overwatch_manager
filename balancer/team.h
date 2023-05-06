#pragma once

#include <QVector>

#include "player.h"

namespace Balancer
{

class Team final
{

public:
    enum class Color : uint8_t
    {
        None,
        Blue,
        Red
    };

    Team() = default;
    Team(const QString& name) noexcept;
    Team(const QVector<Player>& players) noexcept;
    Team(const Color color) noexcept;
    Team(const QString& name, const QVector<Player>& players) noexcept;
    Team(const QString& name, const QVector<Player>& players, const Color color) noexcept;

    const QString toString() const;

    void setName(const QString& name) { m_name = name; }
    void setPlayers(const QVector<Player>& players) { m_players = players; }
    void setColor(const Color color) { m_color = color; }

    const QString name() const { return m_name; }
    const QVector<Player> players() const { return m_players; }
    const Color color() const { return m_color; }

private:
    QString m_name; // may be empty
    QVector<Player> m_players;
    Color m_color = Color::None;
};

} // Balancer
