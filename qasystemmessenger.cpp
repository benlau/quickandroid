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
#define POST_SIGNATURE "(Ljava/lang/String;Ljava/util/Map;)Z"
#define INVOKE_SIGNATURE "(Ljava/lang/String;Ljava/util/Map;)V"


static QVariantMap createVariantMap(jobject data) {
    QVariantMap res;

    QAndroidJniEnvironment env;
    /* Reference : https://community.oracle.com/thread/1549999 */

    // Get the HashMap Class
    jclass jclass_of_hashmap = (env)->GetObjectClass(data);

    // Get link to Method "entrySet"
    jmethodID entrySetMethod = (env)->GetMethodID(jclass_of_hashmap, "entrySet", "()Ljava/util/Set;");

    // Invoke the "entrySet" method on the HashMap object
    jobject jobject_of_entryset = env->CallObjectMethod(data, entrySetMethod);

    // Get the Set Class
    jclass jclass_of_set = (env)->FindClass("java/util/Set"); // Problem during compilation !!!!!

    if (jclass_of_set == 0) {
         qWarning() << "java/util/Set lookup failed\n";
         return res;
    }

    jclass jclass_of_string = env->FindClass("java/lang/String");
    jclass jclass_of_integer = env->FindClass("java/lang/Integer");
    jclass jclass_of_boolean = env->FindClass("java/lang/Boolean");


    // Get link to Method "iterator"
    jmethodID iteratorMethod = env->GetMethodID(jclass_of_set, "iterator", "()Ljava/util/Iterator;");

    // Invoke the "iterator" method on the jobject_of_entryset variable of type Set
    jobject jobject_of_iterator = env->CallObjectMethod(jobject_of_entryset, iteratorMethod);

    // Get the "Iterator" class
    jclass jclass_of_iterator = (env)->FindClass("java/util/Iterator");

    // Get link to Method "hasNext"
    jmethodID hasNextMethod = env->GetMethodID(jclass_of_iterator, "hasNext", "()Z");

    jmethodID nextMethod = env->GetMethodID(jclass_of_iterator, "next", "()Ljava/lang/Object;");

    while (env->CallBooleanMethod(jobject_of_iterator, hasNextMethod) ) {
        QAndroidJniObject entry = env->CallObjectMethod(jobject_of_iterator,nextMethod);
        QAndroidJniObject key = entry.callObjectMethod("getKey","()Ljava/lang/Object;");
        QAndroidJniObject value = entry.callObjectMethod("getValue","()Ljava/lang/Object;");
        QString k = key.toString();

        if (!value.isValid())
            continue;

        if (env->IsInstanceOf(value.object<jobject>(),jclass_of_boolean)) {
            res[k] = QVariant::fromValue<bool>(value.callMethod<jboolean>("booleanValue","()Z"));
        } else if (env->IsInstanceOf(value.object<jobject>(),jclass_of_integer)) {
            res[k] = value.callMethod<jint>("intValue","()I");
        } else if (env->IsInstanceOf(value.object<jobject>(),jclass_of_string)) {
            QString v = value.toString();
            res[k] = v;
        }
    }

    if (env->ExceptionOccurred()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
    }

    // Delete local reference
    return res;
}

static jobject createHashMap(const QVariantMap &data) {
    QAndroidJniEnvironment env;

    jclass mapClass = env->FindClass("java/util/HashMap");

    if (mapClass == NULL)  {
        qWarning() << "Failed to find class" << "java/util/HashMap";
        return NULL;
    }

    jclass integerClass = env->FindClass("java/lang/Integer");

    jmethodID integerConstructor = env->GetMethodID(integerClass, "<init>", "(I)V");

    jclass booleanClass = env->FindClass("java/lang/Boolean");
    jmethodID booleanConstructor = env->GetMethodID(booleanClass,"<init>","(Z)V");


    jsize map_len = data.size();

    jmethodID init = env->GetMethodID(mapClass, "<init>", "(I)V");
    jobject hashMap = env->NewObject( mapClass, init, map_len);

    jmethodID put = env->GetMethodID( mapClass, "put",
                "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;");


    QMapIterator<QString, QVariant> iter(data);
    while (iter.hasNext()) {
        iter.next();

        qDebug() << iter.key() << iter.value();
        QString key = iter.key();
        jstring jkey = env->NewStringUTF(key.toLocal8Bit().data());
        QVariant v = iter.value();
        if (v.type() == QVariant::String) {
            QString str = v.toString();
            jstring vString = env->NewStringUTF(str.toLocal8Bit().data());
            env->CallObjectMethod(hashMap,put,jkey,vString);
        } else if (v.type() == QVariant::Int) {
            jobject integer = env->NewObject(integerClass,integerConstructor,v.toInt());
            env->CallObjectMethod(hashMap,put,jkey,integer);
        } else if (v.type() == QVariant::Bool) {
            jobject boolean = env->NewObject(booleanClass,booleanConstructor,v.toBool());
            env->CallObjectMethod(hashMap,put,jkey,boolean);
        } else {
            qWarning() << "QASystemMessenger::sendMessage() - Non-supported data type : " <<  v.type();
        }
     }

    if (env->ExceptionOccurred()) {
        env->ExceptionDescribe();
        env->ExceptionClear();
    }

    return hashMap;
}

static void invoke(JNIEnv* env,jobject object,jstring name,jobject data) {
    Q_UNUSED(object);
    QString str = env->GetStringUTFChars(name, 0);
    qDebug() << "invoke" << str;

    QVariantMap map = createVariantMap(data);
    qDebug() << "invoke" << str << map;
    if (m_instance.isNull())
        return;

    QMetaObject::invokeMethod(m_instance.data(),"received",Qt::QueuedConnection,
                              Q_ARG(QString, str),
                              Q_ARG(QVariantMap,map));
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
    jobject jData = createHashMap(data);
    bool res = QAndroidJniObject::callStaticMethod<jboolean>(JCLASS_Name, "post",
                                              POST_SIGNATURE,
                                              jName,jData);

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
