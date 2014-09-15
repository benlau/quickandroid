import QtQuick 2.0
import QuickAndroid 0.1

// Ref: list_selector_holo_light.xml

Rectangle {
    id: selector
//    color : "#1F000000"
    color : "#00000000"

    property bool pressed

    states: [
        State {
            name: "Pressed"
            when : selector.pressed

            PropertyChanges {
                target: selector
                color: "#33999999"
            }
        }
    ]


}
