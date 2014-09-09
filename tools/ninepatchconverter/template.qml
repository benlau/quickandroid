import QtQuick 2.0

BorderImage {
    id : borderImage

    source : '%source'

    border.left : '%left'
    border.right : '%right'
    border.top : '%top'
    border.bottom : '%bottom'

    property alias fillArea : fillAreaItem
    readonly property bool ninePatch : true

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: '%fillAreaLeft'
        anchors.rightMargin: '%fillAreaRight'
        anchors.topMargin: '%fillAreaTop'
        anchors.bottomMargin: '%fillAreaBottom'
        readonly property int rightMargin: '%fillAreaRight'
        readonly property int bottomMargin: '%fillAreaBottom'

    }

}
