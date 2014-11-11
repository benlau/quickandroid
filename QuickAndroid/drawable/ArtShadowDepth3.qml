import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem
    readonly property real dp : 3
    readonly property bool ninePatch : true

    source : Qt.resolvedUrl("../drawable-xxhdpi/art_shadow_depth_3.png")

    border.left : 106
    border.right : 106
    border.top : 106
    border.bottom : 106

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 106
        anchors.rightMargin: 106
        anchors.topMargin: 106
        anchors.bottomMargin: 106

        property int rightMargin: 106
        property int bottomMargin: 106
    }

}
