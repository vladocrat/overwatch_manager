#pragma once

#include <vector>

#include "player.h"
#include "team.h"

namespace Balancer
{

struct BalancedTeams
{
    Team blue;
    Team red;
};

class Balancer
{
public:
    Balancer();
    virtual ~Balancer();

    virtual BalancedTeams balance(const std::vector<Player>&) = 0;
};

} // Balancer

