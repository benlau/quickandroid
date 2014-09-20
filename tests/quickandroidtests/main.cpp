#include <QApplication>
#include <QtQuickTest/quicktest.h>
#include <QFileInfo>
#include <QtCore>
#include "quickandroid.h"

int main(int argc, char **argv)
{
    QApplication a(argc, argv);
    QuickAndroid::registerTypes();

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

    for (int i = 1 ; i < args.size();i++) {
        s[idx++] = strdup(args.at(i).toLocal8Bit().data());
    }

    s[idx++] = 0;

    return quick_test_main( idx-1,s,"Quick Android",srcdir.data());
}
