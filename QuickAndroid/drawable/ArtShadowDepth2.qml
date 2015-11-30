import QtQuick 2.0
import QuickAndroid 0.1

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem
    readonly property real dp : 1
    readonly property bool ninePatch : true

    source: "image://quickandroid-drawable/art_shadow_depth_2";

    border.left : 16 * A.dp
    border.right : 16 * A.dp
    border.top : 16 * A.dp
    border.bottom : 16 * A.dp

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 16 * A.dp
        anchors.rightMargin: 16 * A.dp
        anchors.topMargin: 16 * A.dp
        anchors.bottomMargin: 16 * A.dp

        property int rightMargin: 16 * A.dp
        property int bottomMargin: 16 * A.dp
    }

}
