TEMPLATE = app

DEFINES += SRCDIR=\\\"$$PWD/\\\"

QT += qml quick

SOURCES += main.cpp

RESOURCES +=

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    main.qml
