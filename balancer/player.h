#pragma once

#include <typeinfo>
#include <array>
#include <string>

struct Role
{
    enum class Type : uint8_t
    {
        Tank,
        Damage,
        Support
    };

    uint32_t rank;
    Type type;
};

using Roles = std::array<Role, 3>;

struct Player
{
    std::string nickname;
    Roles roles;
};
