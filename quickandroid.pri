
QML_IMPORT_PATH += $$PWD

INCLUDEPATH += $$PWD
RESOURCES += $$PWD/QuickAndroid/quickandroid.qrc

HEADERS += \
    $$PWD/quickandroid.h \
    $$PWD/qadrawableprovider.h \
    $$PWD/qasystemmessenger.h

SOURCES += \
    $$PWD/quickandroid.cpp \
    $$PWD/qadrawableprovider.cpp \
    $$PWD/qasystemmessenger.cpp

android {
    QT += androidextras

    QA_JAVASRC.path = /src/quickandroid
    QA_JAVASRC.files += $$PWD/java/quickandroid/SystemMessenger.java

    INSTALLS += QA_JAVASRC
}

DISTFILES += \
    $$PWD/java/quickandroid/SystemMessenger.java

