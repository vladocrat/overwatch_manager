#include "player.h"

#include <unordered_map>

namespace Balancer
{

namespace Internal
{

static const std::unordered_map<Role::Type, QString, std::hash<Role::Type>> roleTypeStr
{
    {Role::Type::Flex, "Flex"},
    {Role::Type::Damage, "Damage"},
    {Role::Type::Support, "Support"},
    {Role::Type::Flex, "Tank"}
};

static const QString roleTypeToString(Role::Type type)
{
   return roleTypeStr.find(type)->second;
}

static const QString playersToString(const std::array<Player, 5>& players)
{
    QString retVal;

    for (const auto& player: players)
    {
        retVal += player.toString() + " ";
    }

    return retVal;
}

} // Internal

const Role Player::findPreference() const
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

const QString Player::toString() const
{

}

const QString Role::toString() const
{
    return {};
}


} // Balancer
