import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.def 0.1
import "../drawable"

QtObject {
    property color backgroundColor : "#ffffff"

    property int leftPadding : 16 * A.dp
    property int rightPadding: 16 * A.dp

    property int topPadding: 16 * A.dp
    property int bottomPadding : 20 * A.dp

    property int titleKeyline : 72 * A.dp

    property TextStyle titleTextStyle
    property TextStyle valueTextStyle

    property Component divider : ListDivider {}
}

