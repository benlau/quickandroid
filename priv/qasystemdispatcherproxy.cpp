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

void QASystemDispatcherProxy::dispatch(QString type, QVariantMap message)
{
    QASystemDispatcher::instance()->dispatch(type,message);
}

void QASystemDispatcherProxy::loadClass(QString className)
{
    QASystemDispatcher::instance()->loadClass(className);
}
