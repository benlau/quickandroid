import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Item {
    id: pasteButton

    property bool isOpened: false

    property Item item
    property rect itemRectAtRoot
    property rect cursorRectAtRoot
    property rect cursorRect

    signal clicked

    function openAt() {
        var root = parent;
        while (root.parent) {
            root = root.parent;
        }

        var tmpRect = root.mapFromItem(item.parent,item.x,item.y,item.width,item.height);
        itemRectAtRoot = Qt.rect(tmpRect.x,tmpRect.y,tmpRect.width,tmpRect.height);
        isOpened = true;
    }

    function close() {
        isOpened = false;
    }

    onCursorRectChanged: {
        var tmpRect = parent.mapFromItem(item,cursorRect.x,cursorRect.y,cursorRect.width,cursorRect.height);
        cursorRectAtRoot = Qt.rect(tmpRect.x,tmpRect.y,tmpRect.width,tmpRect.height);
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
                backgroundColor: "#E4E4E4";
                text: qsTr("PASTE");

                opacity: isOpened ? 1 : 0
                enabled: isOpened;
                depth: 3
                material: RaisedButtonMaterial {
                    extend: [ThemeManager.currentTheme.raisedButton,{
                        "text.bold": true
                    }]
                }

                onClicked: {
                    pasteButton.clicked();
                    close();
                }
            }

            function reposition() {
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

            Connections {
                target: pasteButton
                onCursorRectAtRootChanged: reposition();
            }

            Component.onCompleted:  {
                reposition();
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
