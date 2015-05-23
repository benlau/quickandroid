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
// Reference : https://community.oracle.com/thread/1549999

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
//    jmethodID intValueMethod = env->GetMethodID(jclass_of_integer,"intValue","()I");

    // Get link to Method "iterator"
    jmethodID iteratorMethod = env->GetMethodID(jclass_of_set, "iterator", "()Ljava/util/Iterator;");

    // Invoke the "iterator" method on the jobject_of_entryset variable of type Set
    jobject jobject_of_iterator = env->CallObjectMethod(jobject_of_entryset, iteratorMethod);

    // Get the "Iterator" class
    jclass jclass_of_iterator = (env)->FindClass("java/util/Iterator");

    // Get link to Method "hasNext"
    jmethodID hasNextMethod = env->GetMethodID(jclass_of_iterator, "hasNext", "()Z");

//    // Invoke - Get the value hasNextMethod
//    jboolean bHasNext = env->CallBooleanMethod(jobject_of_iterator, hasNextMethod);

    // Get link to Method "hasNext"
//    jmethodID nextMethod = env->GetMethodID(jclass_of_iterator, "next", "()Ljava/util/Map/Entry;");
    jmethodID nextMethod = env->GetMethodID(jclass_of_iterator, "next", "()Ljava/lang/Object;");

//    jclass jclass_of_mapentry = (env)->FindClass("java/util/Map/Entry");

//    jmethodID getKeyMethod = env->GetMethodID(jclass_of_mapentry, "getKey", "()Ljava/lang/Object");

//    jmethodID getValueMethod = env->GetMethodID(jclass_of_mapentry, "getValue", "()Ljava/lang/Object");

    while (env->CallBooleanMethod(jobject_of_iterator, hasNextMethod) ) {
//        jobject entry = env->CallObjectMethod(jobject_of_iterator,nextMethod);
        QAndroidJniObject entry = env->CallObjectMethod(jobject_of_iterator,nextMethod);
//        jobject key = (jobject) env->CallObjectMethod(entry,getKeyMethod);
//        jobject value =  env->CallObjectMethod(entry,getValueMethod);
        QAndroidJniObject key = entry.callObjectMethod("getKey","()Ljava/lang/Object;");
        QAndroidJniObject value = entry.callObjectMethod("getValue","()Ljava/lang/Object;");
//        QString k = env->GetStringUTFChars((jstring) key, 0);
        QString k = key.toString();

        if (!value.isValid())
            continue;

        if (env->IsInstanceOf(value.object<jobject>(),jclass_of_integer)) {
            res[k] = value.callMethod<jint>("intValue","()I");
        } else if (env->IsInstanceOf(value.object<jobject>(),jclass_of_string)) {
            QString v = value.toString();
            res[k] = v;
        }
    }

    qDebug() << res;

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

//    jmethodID setIntValue = env->GetMethodID(integerClass,"setIntValue","(I)V");

    jmethodID integerConstructor = env->GetMethodID(integerClass, "<init>", "(I)V");

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
//            QAndroidJniObject integer = QAndroidJniObject("java/lang/Integer");
//            integer.callMethod<void>("setIntValue","(I)V",v.toInt());
//            env->CallObjectMethod(hashMap,put,jkey,integer.object<jobject>());

            jobject integer = env->NewObject(integerClass,integerConstructor,v.toInt());
            env->CallObjectMethod(hashMap,put,jkey,integer);

            //            env->CallVoidMethod(integer,setIntValue,v.toInt());

//              env->CallObjectMethod(hashMap,put,jkey,v.toInt());


        } else {
            qWarning() << "QASystemMessenger::sendMessage() - Non-supported data type : " <<  v.type();
        }
     }

    return hashMap;
}

static void invoke(JNIEnv* env,jobject object,jstring name,jobject data) {
    Q_UNUSED(object);

    QString str = env->GetStringUTFChars(name, 0);
    qDebug() << "invoke" << str << createVariantMap(data) ;
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
