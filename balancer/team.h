#pragma once

#include <array>

#include "player.h"

using Players = std::array<Player, 5>;

struct Team
{
    Players players;
};

