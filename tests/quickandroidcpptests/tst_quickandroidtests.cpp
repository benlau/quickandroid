#include <QString>
#include <QtTest>
#include <QCoreApplication>
#include <QQmlEngine>
#include <QQmlComponent>
#include "quickandroid.h"

class QuickAndroidTests : public QObject
{
    Q_OBJECT

public:
    QuickAndroidTests();

private Q_SLOTS:
    void initTestCase();
    void cleanupTestCase();
    void loading();
};

QuickAndroidTests::QuickAndroidTests()
{
}

void QuickAndroidTests::initTestCase()
{
    QuickAndroid::registerTypes();
}

void QuickAndroidTests::cleanupTestCase()
{
}

void QuickAndroidTests::loading()
{
    QStringList res;
    QQueue<QString> queue;
    queue.enqueue(":/QuickAndroid");

    QQmlEngine engine;
    engine.addImportPath("qrc:///");

    while (queue.size()) {
        QString path = queue.dequeue();
        QDir dir(path);
        QFileInfoList infos = dir.entryInfoList(QStringList());
        for (int i = 0 ; i < infos.size();i++) {
            QFileInfo info = infos.at(i);
            if (info.fileName() == "." || info.fileName() == "..")
                continue;
            if (info.isDir()) {
                queue.enqueue(info.absoluteFilePath());
                continue;
            }
            QUrl url = info.absoluteFilePath().remove(0,1);
            url.setScheme("qrc");

            if (info.suffix() != "qml") {
                continue;
            }

            QQmlComponent comp(&engine);
            comp.loadUrl(url);
            if (comp.isError()) {
                qDebug() << QString("%1 : Load Failed. Reason :  %2").arg(info.absoluteFilePath()).arg(comp.errorString());
            }
            QVERIFY(!comp.isError());

            qDebug() << QString("%1 : Passed").arg(info.absoluteFilePath());
        }
    }
}

QTEST_MAIN(QuickAndroidTests)

#include "tst_quickandroidtests.moc"
