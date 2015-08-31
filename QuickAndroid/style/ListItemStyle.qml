import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.def 0.1
import "../drawable"

QtObject {
    property color backgroundColor : "#ffffff"

    property int leftPadding: 16
    property int rightPadding: 16

    property int textTopPadding: 16
    property int textBottomPadding: 20

    // If icon is present, the left padding of title
    property int titleKeyline: 72

    property TextStyle titleTextStyle
    property TextStyle valueTextStyle : TextStyle {
        textSize: 16
        textColor : Color.black54
    }

    property TextStyle subtitleTextStyle : TextStyle {
        textSize: 14
        textColor : Color.black54
    }

    property Component divider : ListDivider {}
    property int dividerLeftInset : 0

    property int dividerRightInset : 0

}

