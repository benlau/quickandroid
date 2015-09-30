import QtQuick 2.0
import QuickAndroid 0.1

Item {
    id: pasteButton

    property bool isOpened: false

    property rect itemRectAtRoot
    property rect cursorRectAtRoot

    signal clicked

    function openAt(item,cursorRect) {
        var root = parent;
        while (root.parent) {
            root = root.parent;
        }

        var tmpRect = root.mapFromItem(item.parent,item.x,item.y,item.width,item.height);
        itemRectAtRoot = Qt.rect(tmpRect.x,tmpRect.y,tmpRect.width,tmpRect.height);

        tmpRect =root.mapFromItem(item,cursorRect.x,cursorRect.y,cursorRect.width,cursorRect.height);
        cursorRectAtRoot = Qt.rect(tmpRect.x,tmpRect.y,tmpRect.width,tmpRect.height);

        isOpened = true;
    }

    function close() {
        isOpened = false;
    }

    Component {
        id: creator;
        Overlay {
            id: overlay

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onPressed: {
                    mouse.accepted = false;
                    close();
                }
            }

            RaisedButton {
                id: button
                color: "#E4E4E4";
                text: qsTr("PASTE");

                opacity: isOpened ? 1 : 0
                enabled: isOpened;
                depth: 3

                onClicked: {
                    pasteButton.clicked();
                    close();
                }

            }

            Component.onCompleted:  {
                button.x = cursorRectAtRoot.x - button.width / 2
                button.y = itemRectAtRoot.y - button.height;
                if (button.y < 0) {
                    button.y = itemRectAtRoot.y + button.height + 48 * A.dp
                }

                if (button.x < 0)
                    button.x = 0;
                if (button.x + button.width > overlay.width) {
                    button.x = overlay.width- button.width
                }
            }

        }
    }

    Loader {
        id: loader;
    }

    states: [
        State {
            when: isOpened;

            PropertyChanges {
                target: loader
                sourceComponent : creator;
            }

        }

    ]

}
