
QML_IMPORT_PATH += $$PWD

INCLUDEPATH += $$PWD
RESOURCES += $$PWD/QuickAndroid/quickandroid.qrc

HEADERS += \
    $$PWD/quickandroid.h \
    $$PWD/qadrawableprovider.h \
    $$PWD/qasystemdispatcher.h \
    $$PWD/priv/qasystemdispatcherproxy.h

SOURCES += \
    $$PWD/quickandroid.cpp \
    $$PWD/qadrawableprovider.cpp \
    $$PWD/qasystemdispatcher.cpp \
    $$PWD/priv/qasystemdispatcherproxy.cpp \
    $$PWD/priv/qadevice.cpp

android {
    QT += androidextras

    QA_JAVASRC.path = /src/quickandroid
    QA_JAVASRC.files += $$PWD/java/quickandroid/SystemDispatcher.java \
                        $$PWD/java/quickandroid/QuickAndroidActivity.java

    INSTALLS += QA_JAVASRC
}

DISTFILES += \
    $$PWD/java/quickandroid/SystemDispatcher.java \
    $$PWD/java/quickandroid/QuickAndroidActivity.java

