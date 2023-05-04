#pragma once

#include <QString>

namespace Utils
{

//! Every string used to constract an array should be created using this util-class
//! to make the code less clucnky and more consistent when stringifying stuff.
struct QStringArray
{
    QStringArray()
    {
        str += "[ ";
    }

    ~QStringArray()
    {
        str += " ]";
    }

    QString str;
};

} // Utils
