#pragma once

#include "team.h"

class Game
{
public:
    Game(const Team& blue, const Team& red)
        : m_blueTeam(blue), m_redTeam(red) {}

    void setWinner(Team::Color color) { m_winner = color; }
    void setBlueTeam(const Team& team) { m_blueTeam = team; }
    void setRedTeam(const Team& team) { m_redTeam = team; }
    const Team::Color winner() const { return m_winner; }
    const Team blueTeam() const { return m_blueTeam; }
    const Team redTeam() const { return m_redTeam; }

private:
    Team::Color m_winner = Team::Color::None;
    Team m_blueTeam;
    Team m_redTeam;
};

