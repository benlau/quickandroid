import QtQuick 2.0
import QuickAndroid 0.1

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
    property int homeMarginLeft: -2 * A.dp

    property var divider : "#1A000000"
    property var padding : 8 * A.dp

    property int keyline1: 16 * A.dp
    property int keyline2: 72 * A.dp
}
