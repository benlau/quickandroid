#ifndef QASYSTEMDISPATCHERPROXY_H
#define QASYSTEMDISPATCHERPROXY_H

#include <QObject>
#include <QVariantMap>

class QASystemDispatcherProxy : public QObject
{
    Q_OBJECT
public:
    explicit QASystemDispatcherProxy(QObject *parent = 0);
    ~QASystemDispatcherProxy();

    Q_INVOKABLE void dispatch(QString name, QVariantMap message);

signals:
    void dispatched(QString name , QVariantMap data);

};

#endif // QASYSTEMDISPATCHERPROXY_H
