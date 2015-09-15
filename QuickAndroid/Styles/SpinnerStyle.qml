import QtQuick 2.0
import QuickAndroid 0.1

QtObject {
    property var background : Qt.resolvedUrl("../drawable/SpinnerAbHoloLight.qml")
    property var popupBackground : Qt.resolvedUrl("../drawable/SpinnerDropdownBackground.qml")
    property var dropDownSelector : Qt.resolvedUrl("../drawable/ListSelectorHoloLight.qml")
    property int dropDownVerticalOffset : -10 * A.dp
    property TextStyle textStyle;
    property var divider : Qt.resolvedUrl("../drawable/DividerHorizontalHoloLight.qml");
}
