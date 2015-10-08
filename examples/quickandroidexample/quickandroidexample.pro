TEMPLATE = app

QT += qml quick

SOURCES += main.cpp \
    automator.cpp

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
    android-sources/AndroidManifest.xml \
    android-sources/src/quickandroid/example/ExampleService.java \
    README.md

HEADERS += \
    automator.h \
    ../../README.md
