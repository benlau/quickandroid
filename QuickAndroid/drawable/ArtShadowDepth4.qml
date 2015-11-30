import QtQuick 2.0
import QuickAndroid 0.1

BorderImage {
    id : borderImage
    readonly property real dp : 3
    readonly property bool ninePatch : true
    property alias fillArea : fillAreaItem

    source: "image://quickandroid-drawable/art_shadow_depth_4";

    border.left : 36 * A.dp
    border.right : 36 * A.dp
    border.top : 36 * A.dp
    border.bottom : 36 * A.dp

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 36 * A.dp
        anchors.rightMargin: 36 * A.dp
        anchors.topMargin: 36 * A.dp
        anchors.bottomMargin: 36 * A.dp
        readonly property int rightMargin: 36 * A.dp
        readonly property int bottomMargin: 36 * A.dp

    }

}
