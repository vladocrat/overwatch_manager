#pragma once

#include "balancer.h"

class SimpleBalancer final : public Balancer
{
public:
    SimpleBalancer();
    ~SimpleBalancer();

    BalancedTeams balance(const std::vector<Player>&);
};

