
QML_IMPORT_PATH += $$PWD

INCLUDEPATH += $$PWD
RESOURCES += $$PWD/QuickAndroid/quickandroid.qrc

HEADERS += \
    $$PWD/quickandroid.h \
    $$PWD/qadrawableprovider.h \
    $$PWD/qasystemdispatcher.h

SOURCES += \
    $$PWD/quickandroid.cpp \
    $$PWD/qadrawableprovider.cpp \
    $$PWD/qasystemdispatcher.cpp

android {
    QT += androidextras

    QA_JAVASRC.path = /src/quickandroid
    QA_JAVASRC.files += $$PWD/java/quickandroid/SystemDispatcher.java

    INSTALLS += QA_JAVASRC
}

DISTFILES += \
    $$PWD/java/quickandroid/SystemDispatcher.java

