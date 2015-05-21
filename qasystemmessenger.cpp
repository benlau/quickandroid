// Author:  Ben Lau (https://github.com/benlau)
#include <QCoreApplication>
#include <QPointer>
#include <QtCore>
#include "qasystemmessenger.h"

static QPointer<QASystemMessenger> m_instance;

#ifdef Q_OS_ANDROID
#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>

#define JCLASS_Name "quickandroid/SystemMessenger"
#define POST_SIGNATURE "(Ljava/lang/String;)Z"
//#define POST_SIGNATURE "(Ljava/lang/String;Ljava/util/Map;)Z"
#define INVOKE_SIGNATURE "(Ljava/lang/String;)V"

static void invoke(JNIEnv* env,jobject name,jobject data) {
    qDebug() << "invoke";
}

#endif

QASystemMessenger::QASystemMessenger(QObject* parent) : QObject(parent)
{

}

QASystemMessenger::~QASystemMessenger()
{

}

QASystemMessenger *QASystemMessenger::instance()
{
    if (!m_instance) {
        QCoreApplication* app = QCoreApplication::instance();
        m_instance = new QASystemMessenger(app);
    }
    return m_instance;
}

bool QASystemMessenger::sendMessage(QString name, QVariantMap data)
{
#ifdef Q_OS_ANDROID

    qDebug() << "sendMessage" << name << data;
    QAndroidJniEnvironment env;
    jstring jName = env->NewStringUTF(name.toLocal8Bit().data());
    bool res = QAndroidJniObject::callStaticMethod<jboolean>(JCLASS_Name, "post",
                                              POST_SIGNATURE,
                                              jName);

    return res;
#else
    return false;
#endif
}

void QASystemMessenger::registerNatives()
{
#ifdef Q_OS_ANDROID
    QAndroidJniEnvironment env;
    jclass clazz = env->FindClass(JCLASS_Name);
    if (!clazz)
    {
        qCritical() << QString("Can't find %1 class").arg(QString(JCLASS_Name));
        return ;
    }

    JNINativeMethod methods[] =
    {
        {"invoke", INVOKE_SIGNATURE, (void *)&invoke},
    };

    int numMethods = sizeof(methods) / sizeof(methods[0]);
    if (env->RegisterNatives(clazz, methods, numMethods) < 0) {
        if (env->ExceptionOccurred()) {
            env->ExceptionDescribe();
            env->ExceptionClear();
            qCritical() << "Exception occurred!!!";
            return;
        }
    }
#endif
}
