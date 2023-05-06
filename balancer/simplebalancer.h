#pragma once

#include "balancer.h"

namespace Balancer
{

class SimpleBalancer final : public Balancer
{
public:
    SimpleBalancer();
    ~SimpleBalancer();

    BalancedTeams balance(const QVector<Player>&);
};

} // Balancer
