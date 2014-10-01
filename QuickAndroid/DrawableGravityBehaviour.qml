// Place the content item within a drawable according to the gravity.
import QtQuick 2.0

Item {
    id : behaviour
    property var target: parent
    property string gravity : "center"

    property var _fillArea : target.fillArea
    property var _target : _fillArea.children[0]

    states: [State {
        name: "left"
        when: gravity === "left"

            AnchorChanges {
                target: _target
                anchors.left: _fillArea.left
                anchors.verticalCenter: _fillArea.verticalCenter
            }
        },State {
            name: "right"
            when: gravity === "right"

            AnchorChanges {
                target: _target
                anchors.right: _fillArea.right
                anchors.verticalCenter: _fillArea.verticalCenter
            }
        },State {
            name: "top"
            when: gravity === "top"

            AnchorChanges {
                target: _target
                anchors.horizontalCenter: _fillArea.horizontalCenter
                anchors.top: _fillArea.top
            }
        },State {
            name: "bottom"
            when: gravity === "bottom"

            AnchorChanges {
                target: _target
                anchors.horizontalCenter: _fillArea.horizontalCenter
                anchors.bottom: _fillArea.bottom
            }

        },State {
            name : "center"
            when : gravity === "center"
            AnchorChanges {
                target: _target
                anchors.horizontalCenter: _fillArea.horizontalCenter
                anchors.verticalCenter: _fillArea.verticalCenter
            }
        }
    ]
}
