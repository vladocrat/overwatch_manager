#pragma once

#include <typeinfo>
#include <array>
#include <string>

struct Role
{
    enum class Type : uint8_t
    {
        Flex,
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
    Role findPreference() const
    {
        for (const auto& role: roles)
        {
            if (role.type == preference)
            {
                return role;
            }
        }

        //should never be hit
        return {};
    }

    std::string nickname;
    Roles roles;
    Role::Type preference = Role::Type::Flex;
};
