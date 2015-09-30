// Author:  Ben Lau (https://github.com/benlau)
#pragma once
#include <QObject>
#include <QVariantMap>

/// QASystemDispatcher provides an simple messaging interface between C/C++/QML and Java code.

class QASystemDispatcher : public QObject
{
    Q_OBJECT
public:
    ~QASystemDispatcher();
    static QASystemDispatcher* instance();

    /// Dispatch a message via Dispatcher
    /** The message will be first passed to Java's SystemDispatcher and invoke
     * registered listener. Once it is finished, it will emit the
     * "dispatched" signal.
     *
     */
    Q_INVOKABLE void dispatch(QString type , QVariantMap message = QVariantMap());

    /// Register JNI native methods. This function must be called in JNI_OnLoad. Otherwise, the messenger will not be working
    static void registerNatives();

    /// The name of message that will be dispatched during Activity.onActivityResult.
    static QString ACTIVITY_RESULT_MESSAGE;

    /// The name of message that will be dispatched during Activity.onResume.
    static QString ACTIVITY_RESUME_MESSAGE;

signals:
    /// The signal is emitted when a message is dispatched.
    void dispatched(QString type , QVariantMap data);

private:
    explicit QASystemDispatcher(QObject* parent = 0);

};

