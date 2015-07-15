// Author:  Ben Lau (https://github.com/benlau)
#pragma once
#include <QObject>
#include <QVariantMap>

/// QASystemMessenger provides an simple async messaging interface between C/C++/QML and Objective-C source code.

class QASystemDispatcher : public QObject
{
    Q_OBJECT
public:
    ~QASystemDispatcher();
    static QASystemDispatcher* instance();

    /// Deliver a message
    /** If there has a registered helper function , it will return TRUE. Otherwise, it will return FALSE.
     *
     * After processed by the registered helper, the "received" signal will be emitted
     * in next tick of event loop.
     */
    Q_INVOKABLE bool sendMessage(QString name , QVariantMap message = QVariantMap());

    /// Register JNI native methods. This function must be called in JNI_OnLoad. Otherwise, the messenger will not be working
    static void registerNatives();

signals:
    /// The signal is emitted when a message is received.
    void received(QString name , QVariantMap data);

private:
    explicit QASystemDispatcher(QObject* parent = 0);

};

