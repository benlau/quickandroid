/// Timer Utilites
/// Derived from QuickPromise Project

#pragma once
#include <QObject>
#include <QJSValue>

/// QuickPromise's timer utility

class QATimer : public QObject
{
    Q_OBJECT
public:
    explicit QATimer(QObject *parent = 0);
    ~QATimer();

    /// Implement setTimeout function by C++.
    Q_INVOKABLE void setTimeout(QJSValue func,int interval);

private:

    Q_INVOKABLE void onTriggered();

};

