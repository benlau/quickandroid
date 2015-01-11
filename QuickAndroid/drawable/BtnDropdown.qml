import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    id : button
    color : "#00000000"

    property var pressed

    property alias fillArea : fillAreaItem

    Item {
        id : fillAreaItem
        anchors.left: parent.left
        anchors.leftMargin: 12 * A.dp

        anchors.top : parent.top
        anchors.topMargin : 8 * A.dp

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8 * A.dp

        anchors.right: parent.right
        anchors.rightMargin: 12 * A.dp

        readonly property int rightMargin:  12 * A.dp
        readonly property int bottomMargin: 8 * A.dp
    }

    states: [
        State {
            name: "Pressed"
            when : pressed

            PropertyChanges {
                target: button
                color: "#1F000000"
            }
        }
    ]
}
