import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem

    property bool pressed : false
    property bool checked : false

    readonly property bool ninePatch: true
    readonly property int dp : 3

    source : Qt.resolvedUrl("../drawable-xxhdpi/" + "switch_thumb_holo_light.png")

    border.left : 72
    border.right : 72
    border.top : 6
    border.bottom : 6

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 42
        anchors.rightMargin: 42
        anchors.topMargin: 6
        anchors.bottomMargin: 6
        property int rightMargin: 42
        property int bottomMargin: 6
    }

    states: [
        State {
            when: pressed

            PropertyChanges {
                target: borderImage
                source : Qt.resolvedUrl("../drawable-xxhdpi/switch_thumb_pressed_holo_light.png")
            }
        },
        State {
            when: !enabled

            PropertyChanges {
                target: borderImage
                source : Qt.resolvedUrl("../drawable-xxhdpi/switch_thumb_disabled_holo_light.png")
            }
        },
        State {
            when: checked

            PropertyChanges {
                target: borderImage
                source : Qt.resolvedUrl("../drawable-xxhdpi/switch_thumb_activated_holo_light.png")
            }
        }
    ]

}
