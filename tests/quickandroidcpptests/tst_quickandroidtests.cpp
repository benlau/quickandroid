#include <QString>
#include <QtTest>
#include <QCoreApplication>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickView>
#include <QQuickItem>
#include <QPainter>
#include "quickandroid.h"
#include "qadrawableprovider.h"
#include "qaimagewriter.h"

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

    void drawableProvider();
    void drawableProvider_tintColor();

    void imageWriter();
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
    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:///");

    QADrawableProvider* provider = new QADrawableProvider();
    provider->setBasePath("qrc://res");
    engine.addImageProvider("drawable",provider);
    engine.load(QUrl("qrc:/main.qml"));

    wait(800);

    QObject* firstObject = engine.rootObjects().first();
    QQuickWindow *window = qobject_cast<QQuickWindow*>(firstObject);
    QVERIFY(window);

    QObject* rootItem = window->children().first();

    QQuickItem * componentPage = rootItem->findChild<QQuickItem*>("ComponentPage");
    QVERIFY(componentPage);

    QQuickItem * pageStack = rootItem->findChild<QQuickItem*>("PageStack");
    QVERIFY(pageStack);

    QVariantList pages = componentPage->property("pages").toList();

    for (int i = 0 ; i < pages.count() ; i++) {
        QVariantMap item = pages.at(i).toMap();
        QString url = "qrc:/" + item["demo"].toString();
        QMetaObject::invokeMethod(pageStack,"push", Q_ARG(QVariant, url), Q_ARG(QVariant,QVariant()), Q_ARG(QVariant,QVariant()));
        wait(300);
        QMetaObject::invokeMethod(pageStack,"pop", Q_ARG(QVariant,QVariant()));
        wait(300);
    }

    wait(1000);

    QList<QQmlError> errors = view.errors();
    QVERIFY(errors.size() == 0);
}

void QuickAndroidTests::drawableProvider()
{
    QQmlApplicationEngine engine;
    QADrawableProvider* provider = new QADrawableProvider();

    provider->setBasePath(QString(SRCDIR) + "/res");
    engine.addImageProvider("drawable",provider);
    engine.addImportPath("qrc:///");
    engine.load(QUrl::fromLocalFile(QString(SRCDIR) + "/test_drawableprovider.qml"));

    wait(1000);

    QObject *rootItem = engine.rootObjects().first();

    QVERIFY(rootItem);

    QStringList images;
    images << "image1" << "image2" << "image3" << "image4";

    Q_FOREACH(QString image,images) {
        QQuickItem* item = rootItem->findChild<QQuickItem*>(image);
        QVERIFY(item);
        QCOMPARE(item->property("status").toInt() , 1) ;
    }

    QQuickItem *image1 = rootItem->findChild<QQuickItem*>("image1");
    QVERIFY(image1);
    QVERIFY(image1->property("sourceSize").toSize() == QSize(48,48));
    QVERIFY(image1->width() == 48);
    QVERIFY(image1->height() == 48);

    QQuickItem *image4 = rootItem->findChild<QQuickItem*>("image4");
    QVERIFY(image4);
    QVERIFY(image4->property("sourceSize").toSize() == QSize(32,32));
    QVERIFY(image4->width() == 32);
    QVERIFY(image4->height() == 32);

    engine.removeImageProvider("drawable");

}

void QuickAndroidTests::drawableProvider_tintColor()
{
    QQmlApplicationEngine engine;
    QADrawableProvider* provider = new QADrawableProvider();

    provider->setBasePath(QString(SRCDIR) + "/res");
    engine.addImageProvider("drawable",provider);
    engine.load(QUrl::fromLocalFile(QString(SRCDIR) + "/test_drawableprovider_tintcolor.qml"));

    QObject *rootItem = engine.rootObjects().first();

    QVERIFY(rootItem);

    QStringList images;
    images << "image1";

    Q_FOREACH(QString image,images) {
        QQuickItem* item = rootItem->findChild<QQuickItem*>(image);
        QVERIFY(item);
        QCOMPARE(item->property("status").toInt() , 1) ;
    }

    engine.removeImageProvider("drawable");

}

void QuickAndroidTests::imageWriter()
{
    QImage image(100,100,QImage::Format_RGB32);
    QPainter painter(&image);

    QBrush brush;
    brush.setColor(Qt::red);
    brush.setStyle(Qt::SolidPattern);
    painter.setBrush(brush);
    painter.fillRect(QRect(0,0,100,100),brush);
    painter.end();

    // Save image to cache Dir
    QAImageWriter writer;
    QCOMPARE(writer.running(), false);

    // If it is not set during save(). It will generate a url for save automatically
    QVERIFY(writer.fileUrl() == "");

    writer.setImage(image);

    writer.save(); // Don't give any name

    QCOMPARE(writer.running(), true);
    QEventLoop loop;
    connect(&writer,SIGNAL(finished()),
            &loop,SLOT(quit()));
    loop.exec();

    QCOMPARE(writer.running(), false);
    qDebug() << "Saved" << writer.fileUrl();
    QVERIFY(writer.fileUrl() != "");

    writer.clear();
}

QTEST_MAIN(QuickAndroidTests)

#include "tst_quickandroidtests.moc"
