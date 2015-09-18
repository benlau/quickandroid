/**
  Author: benlau
  Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1
import "../drawable"

Style {
    property color backgroundColor : "#ffffff"

    property int leftPadding: 16 * A.dp
    property int rightPadding: 16 * A.dp

    property int textTopPadding: 16 * A.dp
    property int textBottomPadding: 20 * A.dp

    // If icon is present, the left padding of title
    property int titleKeyline: 72 * A.dp

    property bool showDivider: true

    property TextStyle titleTextStyle : TextStyle {
        textSize: 16 * A.dp
        textColor: Constants.black87
    }

    property TextStyle valueTextStyle : TextStyle {
        textSize: 16 * A.dp
        textColor : Constants.black54
    }

    property TextStyle subtitleTextStyle : TextStyle {
        textSize: 14 * A.dp
        textColor : Constants.black54
    }

    property Component divider : ListDivider {}

    property int dividerLeftInset : 0

    property int dividerRightInset : 0

}

