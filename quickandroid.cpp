#include <QtQml>
#include <QVariantMap>
#include "quickandroid.h"
#include "qadevice.h"
#include "qamouseareaproxy.h"
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
    return QADevice::dp();
}

class QuickAndroidRegisterHelper {
public:
    QuickAndroidRegisterHelper() {
        qmlRegisterType<QAMouseAreaProxy>("QuickAndroid.Private",0,1,"MouseAreaProxy");
        qmlRegisterType<QAMouseSensor>("QuickAndroid.Private",0,1,"MouseSensor");
    }
};

static QuickAndroidRegisterHelper registerHelper;
