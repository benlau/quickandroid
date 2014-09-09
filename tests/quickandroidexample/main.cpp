#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:///splash.qml")));
    view.show();

    QVariantMap androidContext; // Information of Android
    androidContext["density"] = 1.0;

#ifdef Q_OS_ANDROID
    QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject resource = activity.callObjectMethod("getResources","()Landroid/content/res/Resources;");
    QAndroidJniObject metrics = resource.callObjectMethod("getDisplayMetrics","()Landroid/util/DisplayMetrics;");
    androidContext["density"] = metrics.getField<float>("density");
    androidContext["dpi"] = metrics.getField<int>("densityDpi");

    qDebug() << "density" << androidContext["density"];
    qDebug() << "dpi" << androidContext["dpi"];
#endif

    QQuickItem *root = view.rootObject();
    QMetaObject::invokeMethod(root,"init",Qt::QueuedConnection,
                              Q_ARG(QVariant,androidContext));

    return app.exec();
}
