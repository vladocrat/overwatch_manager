#include "simplebalancer.h"

#include <algorithm>

namespace Constants
{
    static const uint32_t THRESHOLD = 500;
} // Constants

SimpleBalancer::SimpleBalancer()
{

}

SimpleBalancer::~SimpleBalancer()
{

}

BalancedTeams SimpleBalancer::balance(const std::vector<Player>& players)
{
    //divide players into prefferences
    std::vector<Player> tanks;
    std::vector<Player> damage;
    std::vector<Player> supports;

    populate(players, tanks, damage, supports);

    auto sortFunc = [](const Player& first, const Player& second)
    {
        auto firstRole = first.findPreference();
        auto secondRole = second.findPreference();

        return firstRole.rank < secondRole.rank;
    };

    std::sort(tanks.begin(), tanks.end(), sortFunc);
    std::sort(damage.begin(), damage.end(), sortFunc);
    std::sort(supports.begin(), supports.end(), sortFunc);

    return formTeams(tanks, damage, supports);
}

void SimpleBalancer::populate(const std::vector<Player>& players,
                              std::vector<Player>& tanks,
                              std::vector<Player>& damage,
                              std::vector<Player>& support)
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
            damage.push_back(player);
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

BalancedTeams SimpleBalancer::formTeams(const std::vector<Player>& tanks,
                              const std::vector<Player>& damage,
                              const std::vector<Player>& supports)
{
    auto dmgPlayers = getPlayers(damage);
    PlayerGroup blueDmg = dmgPlayers.first;
    PlayerGroup redDmg = dmgPlayers.second;

    auto supportPlayers = getPlayers(supports);
    PlayerGroup blueSupports = supportPlayers.first;
    PlayerGroup redSupports = supportPlayers.second;

    Team blue;
    Team red;

    auto setTeam = [](Team& team, const PlayerGroup& dmg, const PlayerGroup& supps)
    {
        team.players[1] = dmg[0];
        team.players[2] = dmg[1];
        team.players[3] = supps[0];
        team.players[4] = supps[1];
    };

    blue.players[0] = tanks[0];
    setTeam(blue, blueDmg, blueSupports);

    red.players[0] = tanks[1];
    setTeam(red, redDmg, redSupports);

    return {blue, red};
}

SimpleBalancer::TeamPlayerGroups SimpleBalancer::getPlayers(const std::vector<Player>& role)
{
    std::vector<Player> blue;
    std::vector<Player> red;

    bool found = false;

    for (size_t i = 0; i < role.size(); i++)
    {
        found = false;
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

            auto second = role[j].findPreference().rank;

            if ((first - second) > Constants::THRESHOLD)
            {
                continue;
            }

            found = true;
            blue.push_back(role[i]);
            red.push_back(role[j]);
        }
    }

    return {blue, red};
}




