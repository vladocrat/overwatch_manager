#include "team.h"

#include <unordered_map>

#include "stringarray.h"

namespace Balancer
{

namespace Internal
{

    static const std::unordered_map<Team::Color, QString, std::hash<Team::Color>> colorStr
    {
        {Team::Color::None, "None"},
        {Team::Color::Blue, "Blue"},
        {Team::Color::Red, "Red"}
    };

    static const QString colorToString(Team::Color color)
    {
        return colorStr.find(color)->second;
    }

    static const QString playersToString(const std::array<Player, 5>& players)
    {
        Utils::QStringArray retVal;

        for (const auto& player: players)
        {
            retVal.str += player.toString();
        }

        return retVal.str;
    }

} // Internal

const QString Team::toString() const
{
    return QString()
            .append("Name:" + name)
            .append(" Color: " + Internal::colorToString(color))
            .append(" Players: " + Internal::playersToString(players));
}

// Internal



} // Balancer
