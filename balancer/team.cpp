#include "team.h"

#include <unordered_map>

#include "stringarray.h"

namespace Balancer
{

namespace Internal
{

    const std::unordered_map<Team::Color, QString, std::hash<Team::Color>> colorStr
    {
        {Team::Color::None, "None"},
        {Team::Color::Blue, "Blue"},
        {Team::Color::Red, "Red"}
    };

    const QString colorToString(Team::Color color)
    {
        return colorStr.find(color)->second;
    }

    const Utils::QStringArray playersToString(const QVector<Player>& players)
    {
        Utils::QStringArray retVal;

        for (const auto& player: players)
        {
            retVal += player.toString();
        }

        return retVal;
    }

} // Internal


Team::Team(const QString& name, const QVector<Player>& players) noexcept
    : m_name(name), m_players(players)
{
}

Team::Team(const QString &name, const QVector<Player> &players, const Color color) noexcept
    : m_name(name), m_players(players), m_color(color)
{
}

Team::Team(const QString& name) noexcept
    : m_name(name)
{
}

Team::Team(const QVector<Player>& players) noexcept
    : m_players(players)
{
}

Team::Team(const Color color) noexcept
    : m_color(color)
{
}

const QString Team::toString() const
{
    return QString()
            .append("Name: " + m_name)
            .append(" Color: " + Internal::colorToString(m_color))
            .append(" Players: " + Internal::playersToString(m_players).str);
}

} // Balancer
