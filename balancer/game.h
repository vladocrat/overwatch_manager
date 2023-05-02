#pragma once

#include "team.h"

class Game
{
public:
    Game(const Team& blue, const Team& red)
        : m_blueTeam(blue), m_redTeam(red) {}

    enum class TeamColor : uint8_t
    {
        None,
        Blue,
        Red
    };

    void setWinner(TeamColor color) { m_winner = color; }
    void setBlueTeam(const Team& team) { m_blueTeam = team; }
    void setRedTeam(const Team& team) { m_redTeam = team; }
    const TeamColor winner() const { return m_winner; }
    const Team blueTeam() const { return m_blueTeam; }
    const Team redTeam() const { return m_redTeam; }

private:
    TeamColor m_winner = TeamColor::None;
    Team m_blueTeam;
    Team m_redTeam;
};

