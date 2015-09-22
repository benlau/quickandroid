#include <QObject>
#include <QtQml>
#include "qadevice.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#endif

/* Register a Device singleton object in QuickAndroid package. It provides
 * device related information.
 *
 */

static qreal m_dp = 1;
static qreal m_dpi = 72;

static QJSValue provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);

    QJSValue value = scriptEngine->newObject();
    value.setProperty("dp",m_dp);
    value.setProperty("dpi",m_dpi);

    return value;
}


class QADeviceRegisterHelper {

public:
    QADeviceRegisterHelper() {

#ifdef Q_OS_ANDROID
        QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
        QAndroidJniObject resource = activity.callObjectMethod("getResources","()Landroid/content/res/Resources;");
        QAndroidJniObject metrics = resource.callObjectMethod("getDisplayMetrics","()Landroid/util/DisplayMetrics;");
        m_dp = metrics.getField<float>("density");
        m_dpi = metrics.getField<int>("densityDpi");
#endif

        qmlRegisterSingletonType("QuickAndroid", 0, 1, "Device", provider);
    }
};

static QADeviceRegisterHelper registerHelper;


qreal QADevice::dp()
{
    return m_dp;
}
