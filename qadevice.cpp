#include <QObject>
#include <QtQml>
#include <QSysInfo>
#include <QGuiApplication>
#include "qadevice.h"
#include "qadrawableprovider.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#endif

/*!
   \qmltype Device
   \instantiates QADevice
   \inqmlmodule QuickAndroid 1.0
   \inherits QtObject
   \brief Provider of device related information

 */

static qreal m_dp = 1;
static qreal m_dpi = 72;
static bool m_isTablet = false;

QADevice::QADevice(QObject *parent) : QObject(parent)
{
}

qreal QADevice::readDp()
{
    return m_dp;
}

qreal QADevice::dp() const
{
    return m_dp;
}

qreal QADevice::dpi() const
{
    return m_dpi;
}

/*!
  \qmlproperty bool Device::isTablet

   This property hold an indicator for tablet device
 */

qreal QADevice::isTablet() const
{
    return m_isTablet;
}

/*!
  \qmlproperty string Device::os

   This property hold the name of the type of current running OS
 */

QString QADevice::os() const
{
    return QSysInfo::productType();
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

static void init() {

#ifdef Q_OS_ANDROID
        QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
        QAndroidJniObject resource = activity.callObjectMethod("getResources","()Landroid/content/res/Resources;");
        QAndroidJniObject metrics = resource.callObjectMethod("getDisplayMetrics","()Landroid/util/DisplayMetrics;");
        m_dp = metrics.getField<float>("density");
        m_dpi = metrics.getField<int>("densityDpi");

#if (QT_VERSION >= QT_VERSION_CHECK(5, 6, 0))
        QGuiApplication *app = qobject_cast<QGuiApplication*>(QGuiApplication::instance());
        if (app->testAttribute(Qt::AA_EnableHighDpiScaling)) {
            m_dp = m_dp / app->devicePixelRatio();
            m_dpi = m_dpi / app->devicePixelRatio();
        }
#endif

        /* Is Tablet. Experimental code */

        QAndroidJniObject configuration = resource.callObjectMethod("getConfiguration","()Landroid/content/res/Configuration;");
        int screenLayout = configuration.getField<int>("screenLayout");
        int SCREENLAYOUT_SIZE_MASK = QAndroidJniObject::getStaticField<int>("android/content/res/Configuration","SCREENLAYOUT_SIZE_MASK");
        int SCREENLAYOUT_SIZE_LARGE = QAndroidJniObject::getStaticField<int>("android/content/res/Configuration","SCREENLAYOUT_SIZE_LARGE");

        m_isTablet = (screenLayout & SCREENLAYOUT_SIZE_MASK) >= SCREENLAYOUT_SIZE_LARGE;
#endif

    qmlRegisterSingletonType<QADevice>("QuickAndroid", 0, 1, "Device", provider);
}

Q_COREAPP_STARTUP_FUNCTION(init)
