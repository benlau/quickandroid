import QtQuick 2.0

BorderImage {
    id : borderImage
    readonly property real dp : 3
    readonly property bool ninePatch : true
    property alias fillArea : fillAreaItem

    source : Qt.resolvedUrl("../drawable-xxhdpi/art_shadow_depth_4.png")

    border.left : 108
    border.right : 108
    border.top : 108
    border.bottom : 108

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 108
        anchors.rightMargin: 108
        anchors.topMargin: 108
        anchors.bottomMargin: 108
        readonly property int rightMargin: 108
        readonly property int bottomMargin: 108

    }

}
