import QtQuick 2.0
import QuickAndroid.def 0.1
import QuickAndroid 0.1

Rectangle {
    height: 1 * A.dp
    color : Color.black12

    property int leftInset : 0
    property int rightInset : 0

    anchors {
        left: parent.left
        leftMargin: leftInset
        right: parent.right
        rightMargin: rightInset
    }
}

