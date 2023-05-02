#pragma once

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

    virtual BalancedTeams balance() = 0;
};

