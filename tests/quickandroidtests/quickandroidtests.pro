DEFINES += SRCDIR=\\\"$$PWD/\\\"

QT += qmltest qml quick

TARGET = quickandroidtests
TEMPLATE = app

SOURCES += main.cpp \
    testable.cpp

QMAKE_CXXFLAGS += -Wall -Werror

include(../../quickandroid.pri)

OTHER_FILES += \
    tst_Drawable.qml \
    tst_NinePatch.qml \
    tst_Activity_NoHistory.qml \
    tst_InverseMouseArea.qml \
    tst_RectToRectMatrix.qml \
    tst_RectToRectMatrix.qml \
    tst_DrawableGrowBehaviour.qml \
    tst_ActionBar.qml \
    tst_Shadow.qml \
    tst_Dialog.qml \
    tst_DrawableGravityBehaviour.qml \
    tst_Button.qml \
    tst_Text.qml \
    ../../docs/index.qdoc

DISTFILES += \
    tst_ListItem.qml \
    tst_FloatingActionButton.qml \
    tst_SwipeView.qml \
    tst_TabBar.qml \
    tst_TabView.qml \
    tst_Popup.qml \
    tst_DropDownMenu.qml \
    tst_Activity.qml \
    DarkButtonBackground.qml \
    tst_Style.qml \
    tst_TextField.qml \
    Ruler.qml \
    tst_MouseSensor.qml \
    tst_A.qml \
    tst_Line.qml \
    tst_BottomSheet.qml \
    tst_Activity_appear.qml \
    tst_SystemDispatcher.qml \
    tst_Page.qml \
    tst_PageStack.qml \
    tst_Ink.qml \
    tst_Incubator.qml \
    TestSuite.qml \
    components/DummyPage.qml \
    tst_Dialog_activeFocus.qml \
    drawable/MenuDropdownPanelHoloLight.qml

RESOURCES += \
    qml.qrc

OTHER_FILES += \
    ../../README.md

HEADERS += \
    testable.h
