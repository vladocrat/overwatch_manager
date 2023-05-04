#pragma once

#include <typeinfo>
#include <array>

#include <QString>

namespace Balancer
{

struct Role
{
    enum class Type : uint8_t
    {
        Flex,
        Tank,
        Damage,
        Support
    };

    const QString toString() const;

    uint32_t rank;
    Type type;
};

using Roles = std::array<Role, 3>;

struct Player
{
    const Role findPreference() const;
    const QString toString() const;

    QString nickname;
    Roles roles;
    Role::Type preference = Role::Type::Flex;
};

} // Balancer
