import QtQuick 2.0

BorderImage {
    id : borderImage

    source : "../drawable-xxhdpi/textfield_search_default_holo_light.png"

    border.left : 12
    border.right : 12
    border.top : 0
    border.bottom : 12

    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Repeat

    property alias fillArea : fillAreaItem
    readonly property bool ninePatch : true
    readonly property int dp : 3
    property bool selected: false

    Item {
        id : fillAreaItem
        anchors.fill: parent
        anchors.leftMargin: 4
        anchors.rightMargin: 4
        anchors.topMargin: 0
        anchors.bottomMargin: 4
        readonly property int rightMargin: 4
        readonly property int bottomMargin: 4
    }
    
    states : [
        State {
            when: selected
            PropertyChanges {
                target: borderImage
                source: "../drawable-xxhdpi/textfield_search_selected_holo_light.png"
                verticalTileMode: BorderImage.Repeat
            }
        }
    ]

}
