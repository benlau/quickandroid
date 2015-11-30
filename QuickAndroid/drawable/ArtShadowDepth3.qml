import QtQuick 2.0
import QuickAndroid 0.1

BorderImage {
    id : borderImage

    property alias fillArea : fillAreaItem
    readonly property real dp : 1
    readonly property bool ninePatch : true

    source: "image://quickandroid-drawable/art_shadow_depth_3";

    border.left : 34 * A.dp
    border.right : 34 * A.dp
    border.top : 34 * A.dp
    border.bottom : 34 * A.dp

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 34 * A.dp
        anchors.rightMargin: 34 * A.dp
        anchors.topMargin: 34 * A.dp
        anchors.bottomMargin: 34 * A.dp

        property int rightMargin: 34 * A.dp
        property int bottomMargin: 34 * A.dp
    }

}
