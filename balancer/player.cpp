#include "player.h"

#include <unordered_map>

#include "stringarray.h"

namespace Balancer
{

namespace Internal
{

static const std::unordered_map<Role::Type, QString, std::hash<Role::Type>> roleTypeStr
{
    {Role::Type::Flex, "Flex"},
    {Role::Type::Damage, "Damage"},
    {Role::Type::Support, "Support"},
    {Role::Type::Tank, "Tank"}
};

static const QString roleTypeToString(Role::Type type)
{
   return roleTypeStr.find(type)->second;
}

static const Utils::QStringArray rolesToString(const std::vector<Role>& roles)
{
    Utils::QStringArray retVal;

    for (const auto& role: roles)
    {
        retVal += role.toString() + " ";
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
    return QString()
            .append("Player: ")
            .append("{ ")
            .append(nickname)
            .append(" | ")
            .append(Internal::rolesToString(roles).str)
            .append(" | ")
            .append(Internal::roleTypeToString(preference))
            .append(" }");
}

const QString Role::toString() const
{
    return QString()
            .append("Role: ")
            .append("{ ")
            .append(Internal::roleTypeToString(type))
            .append(" | ")
            .append(QString::number(rank))
            .append(" }");
}


} // Balancer
