#pragma once

#include "balancer.h"

namespace Balancer
{

class SimpleBalancer final : public Balancer
{
public:
    SimpleBalancer();
    ~SimpleBalancer();

    BalancedTeams balance(const std::vector<Player>&);

private:
    void populate(const std::vector<Player>&,
                  std::vector<Player>&,
                  std::vector<Player>&,
                  std::vector<Player>&);

    using PlayerGroup = std::vector<Player>; // should be size 2
    using TeamPlayerGroups = std::pair<PlayerGroup, PlayerGroup>;

    BalancedTeams formTeams(const std::vector<Player>&,
                              const std::vector<Player>&,
                              const std::vector<Player>&);

    TeamPlayerGroups getPlayers(const std::vector<Player>&);
};

} // Balancer
