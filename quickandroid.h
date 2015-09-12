#ifndef QUICKANDROID_H
#define QUICKANDROID_H

#include <QtGlobal>
/// Quick Android Context

class QuickAndroid
{
public:
    static void registerTypes();

    /// Obtain the detected "dp" value.
    /** This function has been deprecated. Please use QADevice::dp()
       @deprecated.
     * @brief dp
     * @return The detected "dp" value
    */
    static qreal dp();
};

#endif // QUICKANDROID_H
