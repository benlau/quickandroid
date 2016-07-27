
QML_IMPORT_PATH += $$PWD

INCLUDEPATH += $$PWD
RESOURCES += $$PWD/QuickAndroid/quickandroid.qrc

HEADERS += \
    $$PWD/quickandroid.h \
    $$PWD/qadrawableprovider.h \
    $$PWD/qasystemdispatcher.h \
    $$PWD/priv/qasystemdispatcherproxy.h \
    $$PWD/qadevice.h \
    $$PWD/qamousesensor.h \
    $$PWD/qatimer.h \
    $$PWD/qaline.h \
    $$PWD/qaimagewriter.h

SOURCES += \
    $$PWD/quickandroid.cpp \
    $$PWD/qadrawableprovider.cpp \
    $$PWD/qasystemdispatcher.cpp \
    $$PWD/priv/qasystemdispatcherproxy.cpp \
    $$PWD/qadevice.cpp \
    $$PWD/qamousesensor.cpp \
    $$PWD/qatimer.cpp \
    $$PWD/qaline.cpp \
    $$PWD/qaqmltypes.cpp \
    $$PWD/qaimagewriter.cpp

QuickAndroidJavaDir = $$PWD/java

android {
    QT += androidextras

    isEmpty(ANDROID_PACKAGE_SOURCE_DIR) {
        message(ANDROID_PACKAGE_SOURCE_DIR is not defined)
    }

    # For project without using gradle
    QA_JAVASRC.path = /src/quickandroid
    QA_JAVASRC.files += $$PWD/java/quickandroid/src/main/java/quickandroid/SystemDispatcher.java \
                        $$PWD/java/quickandroid/src/main/java/quickandroid/QuickAndroidActivity.java \
                        $$PWD/java/quickandroid/src/main/java/quickandroid/ImagePicker.java

    #For "ant" only, if gradle is enabled, it will be ignored.
    INSTALLS += QA_JAVASRC

    # For project built with gradle
#    exists($$ANDROID_PACKAGE_SOURCE_DIR/gradle.properties) {
#        GradleProperties.input = $$PWD/gradle.properties.in
#        GradleProperties.output = $$ANDROID_PACKAGE_SOURCE_DIR/gradle.properties
#        QMAKE_SUBSTITUTES += GradleProperties
#    }
}

DISTFILES += \
    $$PWD/java/quickandroid/SystemDispatcher.java \
    $$PWD/java/quickandroid/QuickAndroidActivity.java \
    $$PWD/java/quickandroid/ImagePicker.java \
    $$PWD/gradle.properties.in

