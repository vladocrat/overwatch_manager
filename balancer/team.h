#pragma once

#include <array>

#include "player.h"

namespace Balancer
{

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
    QString name; // may be empty
    Color color = Color::None;

    const QString toString() const;
};

} // Balancer
