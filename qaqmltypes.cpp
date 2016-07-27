#include <QtQml>
#include "qaline.h"
#include "qaunits.h"
#include "qamousesensor.h"
#include "qatimer.h"
#include "priv/qasystemdispatcherproxy.h"
#include "qaimagewriter.h"

static QObject *systemDispatcherProvider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    QASystemDispatcherProxy* object = new QASystemDispatcherProxy();

    return object;
}

static QJSValue timerProvider(QQmlEngine* engine , QJSEngine *scriptEngine) {
    Q_UNUSED(engine);

    QATimer* timer = new QATimer();

    QJSValue value = scriptEngine->newQObject(timer);
    return value;
}

template <typename T>
static QObject* provider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    T* object = new T();

    return object;
}

static void regiserQmlTypes() {
    // QADevice is a exception. Won't register by QAQmlTypes.

    qmlRegisterSingletonType<QASystemDispatcherProxy>("QuickAndroid", 0, 1,
                                                      "SystemDispatcher", systemDispatcherProvider);

    qmlRegisterSingletonType<QAUnits>("QuickAndroid", 0, 1,
                                      "Units", provider<QAUnits>);

    qmlRegisterType<QALine>("QuickAndroid.Private",0,1,"Line");
    qmlRegisterType<QAMouseSensor>("QuickAndroid.Private",0,1,"MouseSensor");
    qmlRegisterSingletonType("QuickAndroid.Private", 0, 1, "TimerUtils", timerProvider);
    qmlRegisterType<QAImageWriter>("QuickAndroid.Private",0,1,"ImageWriter");
}

Q_COREAPP_STARTUP_FUNCTION(regiserQmlTypes)
