#include <QString>
#include <QtTest>
#include <QCoreApplication>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickView>
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
    void runExample();
};

void wait(int msec)
{
    if (msec == -1) {
        msec = 1000;
    }

    QEventLoop loop;
    QTimer timer;
    QObject::connect(&timer,SIGNAL(timeout()),
            &loop,SLOT(quit()));
    timer.start(msec);
    loop.exec();
}

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

            QFile file(":" + url.path());
            QVERIFY(file.open(QIODevice::ReadOnly));
            QString content = file.readAll();
            content = content.toLower();

            // Skip singleton module as it can not be loaded directly
            if (content.indexOf("pragma singleton") != -1) {
                qDebug() << QString("%1 : Skipped (singleton)").arg(url.toString());
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

void QuickAndroidTests::runExample()
{

    QQuickView view;
//    QQmlApplicationEngine engine;
    view.setMinimumSize(QSize(480,640));
    view.setWidth(480);
    view.setHeight(640);
    view.setResizeMode(QQuickView::SizeRootObjectToView);

    view.engine()->addImportPath("qrc:///");
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();

    wait(6000);

    QList<QQmlError> errors = view.errors();
    QVERIFY(errors.size() == 0);

}

QTEST_MAIN(QuickAndroidTests)

#include "tst_quickandroidtests.moc"
