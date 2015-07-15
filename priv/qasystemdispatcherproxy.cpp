#include <QtQml>
#include "qasystemdispatcherproxy.h"
#include "qasystemdispatcher.h"

QASystemDispatcherProxy::QASystemDispatcherProxy(QObject *parent) : QObject(parent)
{
    connect(QASystemDispatcher::instance(),SIGNAL(dispatched(QString,QVariantMap)),
            this,SIGNAL(dispatched(QString,QVariantMap)));

}

QASystemDispatcherProxy::~QASystemDispatcherProxy()
{

}

void QASystemDispatcherProxy::dispatch(QString name, QVariantMap message)
{
    QASystemDispatcher::instance()->dispatch(name,message);
}

static QObject *provider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    QASystemDispatcherProxy* object = new QASystemDispatcherProxy();

    return object;
}

class QASystemDispatcherProxyRegisterHelper {

public:
    QASystemDispatcherProxyRegisterHelper() {
        qmlRegisterSingletonType<QASystemDispatcherProxy>("QuickAndroid", 0, 1,
                                                          "SystemDispatcher", provider);
    }
};

static QASystemDispatcherProxyRegisterHelper registerHelper;
