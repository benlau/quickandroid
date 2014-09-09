#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFileInfo>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QFileInfo info(QString(SRCDIR) + "/main.qml");

    engine.load(QUrl::fromLocalFile(info.absoluteFilePath()));

    return app.exec();
}
