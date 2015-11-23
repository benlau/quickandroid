/* BottomSheet Component

   Author: Ben Lau
   License: Apache-2.0
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QuickAndroid 0.1
import "./drawable"

Item {
    id: bottomSheet

    property bool isOpened: false
    default property alias content : dragArea.children
    property alias paper: paper
    property bool darkBackground: true

    function open() {
        isOpened = true;
    }

    function close() {
        isOpened = false;
    }

    clip: true
    anchors.fill: parent
    z: Constants.zPopupLayer

    Mask {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: paper.top

        MouseArea {
            anchors.fill: parent
            onPressed: close();
        }
        active: darkBackground && isOpened
        enabled: isOpened
    }

    Paper {
        id: paper
        width: bottomSheet.width
        height: dragArea.height
        y: bottomSheet.height
        property int targetY: bottomSheet.height - paper.height

        function __onDragged() {
            if (paper.y !== bottomSheet.height - paper.height) {
                close();
            }
        }

        MouseArea {
            // Dirty hack for a bug in Qt
            // p.s You can't reproduce on desktop. Use Android.
            anchors.fill: parent

            drag.axis: Drag.YAxis
            drag.target: paper
            drag.minimumY: paper.targetY

            drag.onActiveChanged: {
                if (!drag.active) {
                    paper.__onDragged();
                }
            }
        }

        MouseArea {
            id: dragArea
            width: bottomSheet.width
            height: childrenRect.height

            drag.axis: Drag.YAxis
            drag.target: paper
            drag.filterChildren: true
            drag.minimumY: paper.targetY

            drag.onActiveChanged: {
                if (!drag.active) {
                    paper.__onDragged();
                }
            }
        }
    }

    states : [
        State {
            when: isOpened

            PropertyChanges {
                target: paper

                y: bottomSheet.height - paper.height
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"

            NumberAnimation {
                target: paper
                properties: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    ]
}

