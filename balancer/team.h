#pragma once

#include <array>

#include "player.h"

using Players = std::array<Player, 5>;

struct Team
{
    enum class Color : uint8_t
    {
        None,
        Blue,
        Red
    };

    Players players;
    std::string name; // may be empty
    Color color = Color::None;
};

