#include <QtQml>
#include <QVariant>
#include <QTimer>
#include "qatimer.h"

QATimer::QATimer(QObject *parent) : QObject(parent)
{

}

QATimer::~QATimer()
{

}

void QATimer::setTimeout(QJSValue func, int interval)
{
    // It can't use the Timer from Quick Component to implement the function.
    // Because setTimeout(0) could not be executed in next tick with < Qt 5.4

    QTimer *timer = new QTimer(this);

    connect(timer,SIGNAL(timeout()),
            this,SLOT(onTriggered()),Qt::QueuedConnection);

    QVariant v = QVariant::fromValue<QJSValue>(func);

    timer->setProperty("__quick_android_func___",v);
    timer->setInterval(interval);
    timer->setSingleShot(true);
    timer->start();
}

void QATimer::onTriggered()
{
    QTimer* timer = qobject_cast<QTimer*>(sender());

    QJSValue func = timer->property("__quick_android_func___").value<QJSValue>();

    func.call();

    timer->deleteLater();
}
