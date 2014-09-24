// A behaviour class that could be attacched to TextInput  component to adjust the position of text
import QtQuick 2.0

Item {
    id : behaviour
    property var target: parent
    property string gravity : "center"

    states: [State {
        name: "left"
        when: gravity === "left"

            PropertyChanges {
                target: behaviour.target
                horizontalAlignment: TextInput.AlignLeft
                verticalAlignment  : TextInput.AlignVCenter
            }
        },State {
            name: "right"
            when: gravity === "right"

            PropertyChanges {
                target: behaviour.target
                horizontalAlignment: TextInput.AlignRght
                verticalAlignment  : TextInput.AlignVCenter
            }
        },State {
            name: "top"
            when: gravity === "top"
            PropertyChanges {
                target: behaviour.target
                horizontalAlignment: TextInput.AlignCenter
                verticalAlignment  : TextInput.AlignTop
            }
        },State {
            name: "bottom"
            when: gravity === "bottom"

            PropertyChanges {
                target: behaviour.target
                horizontalAlignment: TextInput.AlignCenter
                verticalAlignment  : TextInput.AlignBottom
            }

        },State {
            name : "center"
            when : gravity === "center"
            PropertyChanges {
                target: behaviour.target
                horizontalAlignment: TextInput.AlignCenter
                verticalAlignment  : TextInput.AlignVCenter
            }
        }
    ]

}
