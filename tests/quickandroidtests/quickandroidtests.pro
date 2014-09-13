DEFINES += SRCDIR=\\\"$$PWD/\\\"

QT += qmltest qml

TARGET = quickandroidtests
TEMPLATE = app

SOURCES += main.cpp

include(../../quickandroid.pri)

OTHER_FILES += \
    tst_Drawable.qml \
    tst_QuickButton.qml \
    tst_NinePatch.qml \
    tst_Activity_NoHistory.qml \
    tst_InverseMouseArea.qml \
    tst_RectToRectMatrix.qml \
    tst_RectToRectMatrix.qml \
    tst_DrawableGrowBehaviour.qml \
    tst_DropDownList.qml \
    tst_ActionBar.qml \
    tst_Shadow.qml \
    tst_Dialog.qml
