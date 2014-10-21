#ifndef QUICKANDROID_H
#define QUICKANDROID_H

/// Quick Android Context

class QuickAndroid
{
public:
    static void registerTypes();

    /// Obtain the detected "dp" value.
    /**
     It must call the registerTypes() function before the function. Otherwise the value will be invalid.
     * @brief dp
     * @return The detected "dp" value
    */
    static qreal dp();
};

#endif // QUICKANDROID_H
