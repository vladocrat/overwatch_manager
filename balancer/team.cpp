#include "team.h"

#include <unordered_map>

namespace Balancer
{

namespace Internal
{

    static const std::unordered_map<Team::Color, std::string, std::hash<Team::Color>> colorStr
    {
        {Team::Color::None, "None"},
        {Team::Color::Blue, "Blue"},
        {Team::Color::Red, "Red"}
    };

    static const std::string colorToString(Team::Color color)
    {
        return colorStr.find(color)->second;
    }

    static const std::string playersToString(const std::array<Player, 5>& players)
    {
        std::string retVal;

        for (const auto& player: players)
        {
            retVal += player.
        }

        return retVal;
    }

} // Internal

const std::string Team::toString() const
{
    return std::string()
            .append("Name:" + name)
            .append(" Color: " + Internal::colorToString(color))
            .append("Players: " + std::string(players.begin(), players.end()));
}

// Internal



} // Balancer
