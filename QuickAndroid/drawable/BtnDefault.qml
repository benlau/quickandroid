import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    id : button
    color : "#00000000"

    property var pressed

    property alias fillArea : fillAreaItem

    Item {
        // BtnDefault is used for menu item and other kind of button.
        // User should define their own style for button.
        id : fillAreaItem
        anchors.fill: parent
    }

    states: [
        State {
            name: "Pressed"
            when : pressed

            PropertyChanges {
                target: button
                color: "#1F000000"
            }
        }
    ]
}
