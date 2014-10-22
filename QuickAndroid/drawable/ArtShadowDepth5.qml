import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem
    readonly property real dp : 3
    readonly property bool ninePatch : true

    source : Qt.resolvedUrl("../drawable-xxhdpi/art_shadow_depth_5.png")

    border.left : 132
    border.right : 132
    border.top : 132
    border.bottom : 132

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 132
        anchors.rightMargin: 132
        anchors.topMargin: 132
        anchors.bottomMargin: 132

        property int rightMargin: 132
        property int bottomMargin: 132
    }

}
