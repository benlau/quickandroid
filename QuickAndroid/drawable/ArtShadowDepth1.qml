import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem

    readonly property real dp : 3
    readonly property bool ninePatch : true

    source : Qt.resolvedUrl("../drawable-xxhdpi/art_shadow_depth_1.png")

    border.left : 24
    border.right : 24
    border.top : 24
    border.bottom : 24

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        anchors.topMargin: 24
        anchors.bottomMargin: 24

        property int rightMargin: 24
        property int bottomMargin: 24
    }
}
