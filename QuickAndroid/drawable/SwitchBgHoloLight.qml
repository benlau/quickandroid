import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem

    property bool focused : false
    readonly property bool ninePatch: true
    readonly property int dp : 3
    source : Qt.resolvedUrl("../drawable-xxhdpi/" + "switch_bg_holo_light.png")

    border.left : 24
    border.right : 30
    border.top : 36
    border.bottom : 42

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 9
        anchors.rightMargin: 6
        anchors.topMargin: 6
        anchors.bottomMargin: 6

        property int rightMargin: 6
        property int bottomMargin: 6

    }


    states: [
        State {
            when: focused

            PropertyChanges {
                target: borderImage
                source : Qt.resolvedUrl("../drawable-xxhdpi/" + "switch_bg_focused_holo_light.png")
            }
        },
        State {
            when: !enabled

            PropertyChanges {
                target: borderImage
                source : Qt.resolvedUrl("../drawable-xxhdpi/" + "switch_bg_disabled_holo_light.png")
            }
        }

    ]


}
