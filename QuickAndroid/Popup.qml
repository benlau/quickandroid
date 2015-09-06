/* Popup Component

  Author: @benlau
  Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1

Item {
    id: popup
    width: 100
    height: 62

    /// The anchor point of the popup.
    /// Possible values: [ Constants.leftTop , Constants.rightTop , Constants.leftBottom, Constants.leftBottom]
    property string anchorPoint : Constants.leftTop

    /// The component (may be a button) to trigger to launch this popup. If it not set, it will be the parent component.
    property var anchorView: parent;

    /// The parent component of the launched popup item. If it is not specificed, it will use the top most component.
    property var viewport: null;

    /// The Paper component behind the popup.
    readonly property alias paper: container

    default property alias content: container.children

    property bool isOpened: false

    property int margin: 8

    property int _paperWidth: 0
    property int _paperHeight: 0

    function open() {
        var root = viewport;
        if (!root)
            root = _topmost();

        layer.parent = root;

        _paperWidth = paper.childrenRect.width
        _paperHeight = paper.childrenRect.height
        console.log(_paperWidth,_paperHeight);

        _move(root);
        _adjustX(root);
        _adjustY(root);
        _shrinkHeight(root);
        isOpened = true;
    }

    function close() {
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
    function _move(viewport) {
        var view = anchorView;
        var pos;

        switch (anchorPoint) {

        case Constants.leftTop:
            pos = viewport.mapFromItem(view.parent,view.x,view.y)
            paper.x = pos.x;
            paper.y = pos.y;
            break;

        case Constants.rightTop:
            pos = viewport.mapFromItem(view.parent,view.x,view.y)
            paper.x = pos.x - paper.width;
            paper.y = pos.y;
            break;

        case Constants.leftBottom:
            pos = viewport.mapFromItem(view.parent,view.x,view.y)
            paper.x = pos.x;
            paper.y = pos.y - paper.height;
            break;

        case Constants.rightBottom:
            pos = viewport.mapFromItem(view.parent,view.x,view.y)
            paper.x = pos.x - paper.width;
            paper.y = pos.y - paper.height;
            break;
        }
    }

    function _adjustX(viewport) {
        if (paper.x + _paperWidth + margin * A.dp > viewport.width) {
            paper.x = viewport.width - _paperWidth - margin * A.dp
        }

        if (paper.x < margin * A.dp) {
            paper.x = margin * A.dp
        }
    }

    function _adjustY(viewport) {
        if (paper.y + _paperHeight + margin * A.dp > viewport.height) {
            paper.y = viewport.height - _paperHeight - margin * A.dp
        }

        if (paper.y < margin * A.dp) {
            paper.y = margin * A.dp
        }
    }

    function _shrinkHeight(viewport) {
        if (paper.y + _paperHeight + margin * A.dp > viewport.height) {
            _paperHeight = viewport.height - paper.y - margin * A.dp;
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

            Keys.onReleased: {
                if (event.key === Qt.Key_Back) {
                    close();
                }
            }
        }

    }

    states: [
        State {
            name: "Opened"
            when: isOpened

            PropertyChanges {
                target: layer
                enabled: true
                opacity: 1
            }

            PropertyChanges {
                target: paper
                focus: true
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
            }
        }
    ]

}
