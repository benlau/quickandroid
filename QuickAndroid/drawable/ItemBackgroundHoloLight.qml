import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    id : component
    color : "#00000000"

    property bool disabled
    property bool pressed

    states: [
        State {
            name: "list_selector_disabled_holo_light"
            when : component.pressed || component.disabled

            PropertyChanges {
                target: component
                color : "#1F000000"
            }
        }
    ]
}
