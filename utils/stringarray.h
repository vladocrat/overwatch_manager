#pragma once

#include <QString>

namespace Utils
{

//! Simple RAII wrapper to make array-like represantation.
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

    template<class T>
    QStringArray operator+=(T t)
    {
        str += t;
        return *this;
    }

    QString str;
};

} // Utils
