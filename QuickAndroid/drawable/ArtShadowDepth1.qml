import QtQuick 2.0
import QuickAndroid 0.1

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem

    readonly property real dp : 1
    readonly property bool ninePatch : true

    source: "image://quickandroid-drawable/art_shadow_depth_1";

    border.left : 8 * A.dp
    border.right : 8 * A.dp
    border.top : 8 * A.dp
    border.bottom : 8 * A.dp

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 8 * A.dp
        anchors.rightMargin: 8 * A.dp
        anchors.topMargin: 8 * A.dp
        anchors.bottomMargin: 8 * A.dp

        property int rightMargin: 8 * A.dp
        property int bottomMargin: 8 * A.dp
    }
}
