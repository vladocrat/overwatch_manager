#pragma once

#include <vector>

#include "player.h"
#include "team.h"

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

