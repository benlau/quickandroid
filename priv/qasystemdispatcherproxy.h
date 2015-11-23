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

    Q_INVOKABLE void dispatch(QString type, QVariantMap message = QVariantMap());

    Q_INVOKABLE void loadClass(QString className);

signals:
    void dispatched(QString type , QVariantMap message);

};

#endif // QASYSTEMDISPATCHERPROXY_H
