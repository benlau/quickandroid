import QtQuick 2.0

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem

    readonly property bool ninePatch : true
    readonly property int dp : 3

    source : "../drawable-xxhdpi/menu_dropdown_panel_holo_light.png"

    border.left : 30
    border.right : 30
    border.top : 30
    border.bottom : 30

    Item {
        readonly property int rightMargin : 24
        readonly property int bottomMargin : 24
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        anchors.topMargin: 24
        anchors.bottomMargin: 24
    }

}
