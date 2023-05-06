#pragma once

#include <QVector>

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

    virtual BalancedTeams balance(const QVector<Player>&) = 0;
};

} // Balancer

