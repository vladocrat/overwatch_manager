#include "simplebalancer.h"

#include <algorithm>
#include <cmath>

#include <QDebug>
#include <QMap>

namespace Balancer
{

namespace Internal
{

namespace Constants
{
    static const uint32_t THRESHOLD = 500;
} // Constants

void populate(const QVector<Player>& players,
              QVector<Player>& tanks,
              QVector<Player>& damage,
              QVector<Player>& supports)
{
    for (const auto& player: players)
    {
        using Role = Role::Type;

        switch (player.preference)
        {
        case Role::Tank:
        {
            tanks.push_back(player);
            break;
        }
        case Role::Damage:
        {
            damage.push_back(player);
            break;
        }
        case Role::Support:
        {
            supports.push_back(player);
            break;
        }
        case Role::Flex:
        {
            //TODO decide
            break;
        }
        }
    }
}

using PlayerGroup = QVector<Player>; // should be size 2
using TeamPlayerGroups = std::pair<PlayerGroup, PlayerGroup>;

TeamPlayerGroups getPlayers(const QVector<Player>& role)
{
    QMap<Player, bool> playerTaken;

    for (const auto& player: role)
    {
        playerTaken.insert(player, true);
    }

    auto taken = [&](const Player& p)
    {
        return !playerTaken.value(p);
    };

    QVector<Player> blue;
    QVector<Player> red;

    bool found = false;

    for (size_t i = 0; i < playerTaken.size(); i++)
    {
        found = false;

        if (taken(role[i]))
        {
            continue;
        }

        auto first = role[i].findPreference().rank;

        for (size_t j = 0; j < role.size(); j++)
        {
            if (found)
            {
                break;
            }

            if (j == i)
            {
                continue;
            }

            if (taken(role[j]))
            {
                continue;
            }

            auto second = role[j].findPreference().rank;

            qDebug() << "first: " << first << " second: " << second;

            auto comparing = [&](const uint32_t first, const uint32_t second)
            {
                if ((first - second) > Constants::THRESHOLD)
                {
                    return;
                }

                found = true;
                blue.push_back(role[i]);
                playerTaken[role[i]] = false;
                red.push_back(role[j]);
                playerTaken[role[j]] = false;
            };

            if (first < second)
            {
                comparing(second, first);
            }
            else
            {
                comparing(first, second);
            }
        }
    }

    return {blue, red};
}

BalancedTeams formTeams(const QVector<Player>& tanks,
                        const QVector<Player>& damage,
                        const QVector<Player>& supports)
{
    auto dmgPlayers = Internal::getPlayers(damage);
    auto blueDmg = dmgPlayers.first;
    auto redDmg = dmgPlayers.second;

    auto supportPlayers = Internal::getPlayers(supports);
    auto blueSupports = supportPlayers.first;
    auto redSupports = supportPlayers.second;

    Team blue;
    Team red;

    auto setTeam = [](Team& team, const PlayerGroup& dmg, const PlayerGroup& supps)
    {
        auto players = team.players();

        players.push_back(dmg[0]);
        players.push_back(dmg[1]);
        players.push_back(supps[0]);
        players.push_back(supps[1]);

        team.setPlayers(players);
    };

    QVector<Player> bluePlayers;
    bluePlayers.push_back(tanks[0]);
    blue.setPlayers(bluePlayers);
    setTeam(blue, blueDmg, blueSupports);

    QVector<Player> redPlayers;
    redPlayers.push_back(tanks[1]);
    red.setPlayers(redPlayers);
    setTeam(red, redDmg, redSupports);

    return {blue, red};
}

} // Internal

SimpleBalancer::SimpleBalancer()
{

}

SimpleBalancer::~SimpleBalancer()
{

}


BalancedTeams SimpleBalancer::balance(const QVector<Player>& players)
{
    //divide players into prefferences
    QVector<Player> tanks;
    QVector<Player> damage;
    QVector<Player> supports;

    Internal::populate(players, tanks, damage, supports);

    auto sortFunc = [](const Player& first, const Player& second)
    {
        auto firstRole = first.findPreference();
        auto secondRole = second.findPreference();

        return firstRole.rank > secondRole.rank;
    };

    std::sort(tanks.begin(), tanks.end(), sortFunc);
    std::sort(damage.begin(), damage.end(), sortFunc);
    std::sort(supports.begin(), supports.end(), sortFunc);

    return Internal::formTeams(tanks, damage, supports);
}

} // Balancer
