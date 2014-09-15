import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    id : component
    color : "#00000000"

    implicitWidth: 16 * A.dp

    property bool disabled
    property bool pressed
    property bool focused
    property alias fillArea : fillAreaItem

    Item {
        id : fillAreaItem
        anchors.left: parent.left
        anchors.leftMargin: 6 * A.dp

        anchors.top : parent.top
        anchors.topMargin : 6 * A.dp

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6 * A.dp

//        anchors.right: triangle.left
        anchors.right: parent.right
        anchors.rightMargin: (12 + 4 + 6) * A.dp

        readonly property int rightMargin: (12 + 4 + 6) * A.dp
        readonly property int bottomMargin: 6 * A.dp
    }

    Triangle {
        id : triangle
        corner: 2
        // spinner_ab_default_holo_light
        color : "#333333"
        width : 12 * A.dp
        height : 12 * A.dp
        anchors.right: parent.right
        anchors.rightMargin: 4 * A.dp
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6 * A.dp
    }

    states: [
        State {
            name: "spinner_ab_disabled_holo_light"
            when : component.disabled

            PropertyChanges {
                target: triangle
                color : "#33333333"
            }
        },

        State {
            name: "spinner_ab_pressed_holo_light"
            when : component.pressed

            PropertyChanges {
                target: component
                color : "#40f0f0f0"
            }

            PropertyChanges {
                target: triangle
                color : "#b3d9d9d9"
            }
        },
        State {
            name: "spinner_ab_focused_holo_light"
            when : component.pressed

            PropertyChanges {
                target: component
                color : "#4d33b5e5"
            }

            PropertyChanges {
                target: triangle
                color : "#b8334951"
            }
        }

    ]

}
