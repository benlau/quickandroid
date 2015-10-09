/* Popup Component

  Author: Ben Lau
  License: Apache-2.0
  Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1

FocusScope {
    id: popup

    /// The anchor point of the popup.
    /// Possible values: [ Constants.leftTop , Constants.rightTop , Constants.leftBottom, Constants.leftBottom]
    property string anchorPoint : Constants.leftTop

    /// The component (may be a button) to trigger to launch this popup. If it not set, it will be the parent component.
    property var anchorView: parent;

    /// The parent component of the launched popup item. If it is not specificed, it will use the top most component.
    property var window: null;

    /// The Paper component behind the popup.
    readonly property alias paper: container

    default property alias content: container.content

    property bool isOpened: false

    property int margin: 8

    property int _paperWidth: 0
    property int _paperHeight: 0

    signal aboutToOpen
    signal opened

    signal aboutToClose
    signal closed

    function open() {
        if (isOpened)
            return;

        aboutToOpen();

        var root = window;
        if (!root)
            root = _topmost();

        layer.parent = root;

        if (content.length > 0) {
            var child = content[0];
            _paperWidth = child.implicitWidth > 0 ? child.implicitWidth : Math.max(child.childrenRect.width,child.width);
            _paperHeight = child.implicitHeight > 0 ? child.implicitHeight : Math.max(child.childrenRect.height,child.height);
        } else {
            _paperWidth = 240 * A.dp;
            _paperHeight = 80 * A.dp;
        }

        _move(root);
        _adjustX(root);
        _adjustY(root);
        _shrinkHeight(root);
        isOpened = true;
    }

    function close() {
        if (!isOpened)
            return;

        aboutToClose();

        isOpened = false;
    }

    // Find the top most component
    function _topmost() {
        var p = parent;

        while (p.parent) {
            p = p.parent;
        }
        return p;
    }

    // Move the paper according to the anchorPoint and anchorView
    function _move(window) {
        var view = anchorView;
        var pos;

        switch (anchorPoint) {

        case Constants.leftTop:
            pos = window.mapFromItem(view.parent,view.x,view.y)
            paper.x = pos.x;
            paper.y = pos.y;
            break;

        case Constants.rightTop:
            pos = window.mapFromItem(view.parent,view.x + view.width,view.y)
            paper.x = pos.x - _paperWidth;
            paper.y = pos.y;
            break;

        case Constants.leftBottom:
            pos = window.mapFromItem(view.parent,view.x,view.y + view.height)
            paper.x = pos.x;
            paper.y = pos.y - _paperHeight;
            break;

        case Constants.rightBottom:
            pos = window.mapFromItem(view.parent,view.x + view.width,view.y + view.height)
            paper.x = pos.x - _paperWidth;
            paper.y = pos.y - _paperHeight;
            break;
        }
    }

    function _adjustX(window) {
        if (paper.x + _paperWidth + margin * A.dp > window.width) {
            paper.x = window.width - _paperWidth - margin * A.dp
        }

        if (paper.x < margin * A.dp) {
            paper.x = margin * A.dp
        }
    }

    function _adjustY(window) {
        if (paper.y + _paperHeight + margin * A.dp > window.height) {
            paper.y = window.height - _paperHeight - margin * A.dp
        }

        if (paper.y < margin * A.dp) {
            paper.y = margin * A.dp
        }
    }

    function _shrinkHeight(window) {
        if (paper.y + _paperHeight + margin * A.dp > window.height) {
            _paperHeight = window.height - paper.y - margin * A.dp;
        }
    }

    Item {
        id: layer
        anchors.fill: parent
        enabled: false
        opacity: 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                popup.close();
            }
        }

        MouseArea {
            // block mouse event
            anchors.fill: container
        }

        Paper {
            id: container
            width: 0
            height: 0
            z: Constants.zPopupLayer
        }

    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            close();
            event.accepted = true;
        }
    }

    states: [    
        State {
            name: "Opened"
            when: isOpened

            PropertyChanges {
                target: popup
                focus: true;
            }

            PropertyChanges {
                target: layer
                enabled: true
                opacity: 1
            }

            PropertyChanges {
                target: paper
                height: _paperHeight
                width: _paperWidth
            }
        }

    ]

    transitions: [
        Transition {
            from: ""
            to: "Opened"

            NumberAnimation {
                target: layer
                property: "opacity"
                duration: 300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: paper
                property: "height"
                duration: 300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: paper
                property: "width"
                duration: 100
                easing.type: Easing.InOutQuad
            }

            SequentialAnimation {
                PauseAnimation {
                    duration: 300
                }

                ScriptAction {
                    script: popup.opened();
                }
            }
        },

        Transition {
            from: "Opened"
            to: ""

            NumberAnimation {
                target: layer
                property: "opacity"
                duration: 300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: paper
                property: "height"
                duration: 300
                easing.type: Easing.InOutQuad
            }

            SequentialAnimation {
                PauseAnimation {
                    duration: 200
                }

                NumberAnimation {
                    target: paper
                    property: "width"
                    duration: 100
                    easing.type: Easing.InOutQuad
                }

                ScriptAction {
                    script: popup.closed();
                }
            }
        }
    ]

}

