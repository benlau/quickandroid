#include <QApplication>
#include <QtQuickTest/quicktest.h>
#include <QFileInfo>
#include <QtCore>
#include <QtQml>
#include "quickandroid.h"
#include "testable.h"

int waitTime = 1000;

static QJSValue envProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    QJSValue value = scriptEngine->newObject();
    value.setProperty("waitTime", waitTime);
    return value;
}

static QObject* testableProvider(QQmlEngine* engine,QJSEngine* scriptEngine){
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);


    Testable *testable = new Testable();

    return testable;
}

int main(int argc, char **argv)
{
    QApplication a(argc, argv);
    QuickAndroid::registerTypes();
    qmlRegisterSingletonType("QuickAndroid", 0, 1, "TestEnv", envProvider);
    qmlRegisterSingletonType<Testable>("QuickAndroid",0,1,"Testable",testableProvider);

    QStringList args = a.arguments();
    QString executable = args.at(0);

    QFileInfo info(QString(SRCDIR) + "/../..");
    QString qrc = QString("qrc:///");
    char **s = (char**) malloc(sizeof(char*) * (10 + args.size() ) );
    int idx = 0;

    QByteArray srcdir = info.absoluteFilePath().toLocal8Bit();

    s[idx++] = executable.toLocal8Bit().data();
    s[idx++] = strdup("-import");
    s[idx++] = srcdir.data();
    s[idx++] = strdup("-import");
    s[idx++] = qrc.toLocal8Bit().data();

    if (args.size() > 1)
        waitTime = 60000; // The wait time should be longer if user asked to run specific test case

    for (int i = 1 ; i < args.size();i++) {
        s[idx++] = strdup(args.at(i).toLocal8Bit().data());
    }

    s[idx++] = 0;

    return quick_test_main( idx-1,s,"Quick Android",srcdir.data());
}
