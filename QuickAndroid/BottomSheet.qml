import QtQuick 2.0
import QtQuick.Controls 1.2
import QuickAndroid 0.1
import "./drawable"

Item {
    id: bottomSheet

    property bool isOpened: false
    default property alias content : paper.children
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
        anchors.fill: parent
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
        height: childrenRect.height
        y: bottomSheet.height
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

