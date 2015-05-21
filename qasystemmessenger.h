// Author:  Ben Lau (https://github.com/benlau)
#ifndef QASYSTEMMESSENGER_H
#define QASYSTEMMESSENGER_H

#include <QObject>
#include <QVariantMap>

/// QASystemMessenger provides an simple async messaging interface between C/C++/QML and Objective-C source code.

class QASystemMessenger : public QObject
{
    Q_OBJECT
public:
    ~QASystemMessenger();
    static QASystemMessenger* instance();

    /// Deliver a message
    /** If there has a registered helper function , it will return TRUE. Otherwise, it will return FALSE.
     *
     * After processed by the registered helper, the "received" signal will be emitted
     * in next tick of event loop.
     */
    Q_INVOKABLE bool sendMessage(QString name , QVariantMap data = QVariantMap());

    /// Register JNI native methods. This function must be called in JNI_OnLoad. Otherwise, the messenger will not be working
    static void registerNatives();

signals:
    /// The signal is emitted when a message is received.
    void received(QString name , QVariantMap data);

private:
    explicit QASystemMessenger(QObject* parent = 0);

};

#endif // QASYSTEMMESSENGER_H
