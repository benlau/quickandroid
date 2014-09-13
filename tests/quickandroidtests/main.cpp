#include <QApplication>
#include <QtQuickTest/quicktest.h>
#include <QFileInfo>
#include <QtCore>

int main(int argc, char **argv)
{
    QApplication a(argc, argv);
    QStringList args = a.arguments();
    QString executable = args.at(0);

    QFileInfo info(QString(SRCDIR) + "/../..");

    char **s = (char**) malloc(sizeof(char*) * 10);
    int idx = 0;

    QByteArray srcdir = info.absoluteFilePath().toLocal8Bit();
    s[idx++] = executable.toLocal8Bit().data();
    s[idx++] = "-import";
    s[idx++] = srcdir.data();
    s[idx++] = 0;

    return quick_test_main( idx-1,s,"Quick Android",srcdir.data());
}
