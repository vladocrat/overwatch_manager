#pragma once

#include <typeinfo>
#include <vector>

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

struct Player
{
    const Role findPreference() const;
    const QString toString() const;

    friend bool operator<(const Player& first, const Player& second)
    {
        auto fRank = first.findPreference().rank;
        auto sRank = second.findPreference().rank;

        return fRank < sRank;
    }

    QString nickname;
    std::vector<Role> roles;
    Role::Type preference = Role::Type::Flex;
};

} // Balancer
