import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.def 0.1
import "../drawable"

QtObject {
    property color backgroundColor : "#ffffff"

    property int leftPadding : 16 * A.dp
    property int rightPadding: 16 * A.dp

    property int textTopPadding: 16 * A.dp
    property int textBottomPadding : 20 * A.dp

    property int titleKeyline : 72 * A.dp

    property TextStyle titleTextStyle
    property TextStyle valueTextStyle

    property TextStyle subTitleTextStyle : TextStyle {
        textSize: 14
        textColor : Color.black54
    }

    property Component divider : ListDivider {}
    property int dividerLeftInset : 0

    property int dividerRightInset : 0

}

