
QML_IMPORT_PATH += $$PWD

INCLUDEPATH += $$PWD
RESOURCES += $$PWD/QuickAndroid/quickandroid.qrc

HEADERS += \
    $$PWD/quickandroid.h

SOURCES += \
    $$PWD/quickandroid.cpp

android {
    QT += androidextras
}

