#include <QObject>
#include <QtQml>
#include "qadevice.h"
#include "qadrawableprovider.h"

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

QADevice::QADevice(QObject *parent) : QObject(parent)
{
}

qreal QADevice::readDp()
{
    return m_dp;
}

qreal QADevice::dp()
{
    return m_dp;
}

qreal QADevice::dpi()
{
    return m_dpi;
}

static QObject *provider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    QADevice* device = new QADevice();

    if (!engine->imageProvider("quickandroid-drawable")) {
        QADrawableProvider* provider = new QADrawableProvider();
        provider->setBasePath("qrc:///QuickAndroid");
        engine->addImageProvider("quickandroid-drawable",provider);
    }

    return device;
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

        qmlRegisterSingletonType<QADevice>("QuickAndroid", 0, 1, "Device", provider);
    }
};

static QADeviceRegisterHelper registerHelper;

