DEFINES += SRCDIR=\\\"$$PWD/\\\"

QT += qmltest qml quick

TARGET = quickandroidtests
TEMPLATE = app

SOURCES += main.cpp

include(../../quickandroid.pri)

OTHER_FILES += \
    tst_Drawable.qml \
    tst_NinePatch.qml \
    tst_Activity_NoHistory.qml \
    tst_InverseMouseArea.qml \
    tst_RectToRectMatrix.qml \
    tst_RectToRectMatrix.qml \
    tst_DrawableGrowBehaviour.qml \
    tst_DropDownList.qml \
    tst_ActionBar.qml \
    tst_Shadow.qml \
    tst_Dialog.qml \
    tst_DrawableGravityBehaviour.qml \
    tst_QATextInput.qml \
    tst_Switch.qml \
    tst_Text.qml

DISTFILES += \
    tst_QuickButton.qml \
    tst_ListItem.qml \
    tst_FloatingActionButton.qml \
    tst_SwipeView.qml \
    tst_TabBar.qml

RESOURCES += \
    qml.qrc
