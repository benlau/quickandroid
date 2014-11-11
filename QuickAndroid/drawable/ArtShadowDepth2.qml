import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem
    readonly property real dp : 3
    readonly property bool ninePatch : true

    source : Qt.resolvedUrl("../drawable-xxhdpi/art_shadow_depth_2.png")

    border.left : 48
    border.right : 48
    border.top : 48
    border.bottom : 48

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 48
        anchors.rightMargin: 48
        anchors.topMargin: 48
        anchors.bottomMargin: 48

        property int rightMargin: 48
        property int bottomMargin: 48
    }

}
