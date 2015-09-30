import QtQuick 2.0
import QuickAndroid 0.1

RaisedButton {
    id: pasteButton
    color: "#E4E4E4";
    text: qsTr("PASTE");

    opacity: isOpened ? 1 : 0
    enabled: isOpened;
    depth: 3

    property bool isOpened: false

    function openAt(rect) {
        pasteButton.x = rect.x - pasteButton.width / 2;
        pasteButton.y = rect.y - pasteButton.height
        isOpened = true;
    }

    function close(rect) {
        isOpened = false;
    }


    function _topMostItem() {
        var p = parent;

        while (p.parent) {
            p = p.parent;
        }
        return p;
    }

    function _windowPos(root) {
        return root.mapFromItem(parent,pasteButton.x,pasteButton.y,
                                pasteButton.width,pasteButton.height)
    }

    onClicked: {
        close();
    }

    InverseMouseArea {
        id: mouseArea;
        anchors.fill: parent
        enabled: isOpened;
        onPressed: close();
    }
}
