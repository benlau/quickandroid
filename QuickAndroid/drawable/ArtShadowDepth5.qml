import QtQuick 2.0
import QuickAndroid 0.1

BorderImage {
    id : borderImage
    readonly property real dp : 1
    readonly property bool ninePatch : true
    property alias fillArea : fillAreaItem

    source: "image://quickandroid-drawable/art_shadow_depth_5";

    border.left : 44 * A.dp
    border.right : 44 * A.dp
    border.top : 44 * A.dp
    border.bottom : 44 * A.dp

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 44 * A.dp
        anchors.rightMargin: 44 * A.dp
        anchors.topMargin: 44 * A.dp
        anchors.bottomMargin: 44 * A.dp
        readonly property int rightMargin: 44 * A.dp
        readonly property int bottomMargin: 44 * A.dp

    }

}
