#pragma once

#include <array>

#include "player.h"

using Players = std::array<Player, 10>;

class Team
{
public:
    Team();

    const Players players() const { return m_players; }
    void setPlayers(const Players& players) { m_players = players; }

private:
    Players m_players;
};

