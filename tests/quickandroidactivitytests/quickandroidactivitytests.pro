TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

include(../../quickandroid.pri)

android {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
}

DISTFILES += \
    android-sources/src/quickandroid/UnitTestsActivity.java

