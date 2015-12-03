#include <QtQml>
#include <QVariantMap>
#include "quickandroid.h"
#include "qadevice.h"
#include "qamousesensor.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#endif

void QuickAndroid::registerTypes()
{
    // "A" has been changed to a QML object. So now this function will do nothing.
    // Keep here for compatible purpose only.
}

qreal QuickAndroid::dp()
{
    return QADevice::readDp();
}

