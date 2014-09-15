#include <QtQml>
#include <QVariantMap>
#include "quickandroid.h"

#ifdef Q_OS_ANDROID
#include <QAndroidJniEnvironment>
#include <QAndroidJniObject>
#endif

//static QVariantMap data;
static qreal dp = 1;
static qreal dpi = 72;

static QJSValue aProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);

    QJSValue value = scriptEngine->newObject();
    value.setProperty("dp",dp);
    value.setProperty("dpi",dpi);

    return value;
}

void QuickAndroid::registerTypes()
{
    Q_UNUSED(dpi);
#ifdef Q_OS_ANDROID
    QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject resource = activity.callObjectMethod("getResources","()Landroid/content/res/Resources;");
    QAndroidJniObject metrics = resource.callObjectMethod("getDisplayMetrics","()Landroid/util/DisplayMetrics;");
    dp = metrics.getField<float>("density");
    dpi = metrics.getField<int>("densityDpi");
#endif
    qmlRegisterSingletonType("QuickAndroid", 0, 1, "A", aProvider);
}
