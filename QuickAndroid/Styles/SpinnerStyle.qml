import QtQuick 2.0

QtObject {
    property var background : Qt.resolvedUrl("../drawable/SpinnerAbHoloLight.qml")
    property var popupBackground : Qt.resolvedUrl("../drawable/SpinnerDropdownBackground.qml")
    property var dropDownSelector : Qt.resolvedUrl("../drawable/ListSelectorHoloLight.qml")
    property int dropDownVerticalOffset : -10
    property TextStyle textStyle;
    property var divider : Qt.resolvedUrl("../drawable/DividerHorizontalHoloLight.qml");
}
