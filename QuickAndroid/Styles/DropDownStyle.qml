import QtQuick 2.0
import "../drawable"

QtObject {
    property var background
    property int verticalOffset
    property TextStyle textStyle
    property Component divider : ListDivider { }

    // Custom Style
    property var button

    property var windowEnterAnimation
    property var windowExitAnimation
}
