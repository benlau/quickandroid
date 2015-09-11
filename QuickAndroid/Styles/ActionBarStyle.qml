import QtQuick 2.0

/** Action Bar Style Component

  Author : benlau
 */

QtObject {
    property var iconSource : ""
    property size iconSourceSize

    property var background
    property var actionButtonBackground
    property TextStyle titleTextStyle
    property var homeAsUpIndicator
    property int homeMarginLeft: -2

    property var divider : "#1A000000"
    property var padding : 8

    property int keyline1: 16
    property int keyline2: 72
}
