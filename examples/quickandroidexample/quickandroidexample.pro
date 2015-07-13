TEMPLATE = app

QT += qml quick

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
# QML_IMPORT_PATH += ../..

include(../../quickandroid.pri)

android {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
}

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android-sources/src/quickandroid/example/ExampleActivity.java \
    android-sources/AndroidManifest.xml
