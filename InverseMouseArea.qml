import QtQuick 2.0

Item {
    id : component
    width: 100
    height: 62

    property alias sensingArea : component

    property var _mouseArea
    signal pressed

    function setupMouseArea() {
        var p = sensingArea;

        while (p.parent) {
            p = p.parent;
        }

        if (!_mouseArea) {
            _mouseArea = mouseAreaBuilder.createObject();
        }
        _mouseArea.parent = p;
    }

    function inSensingArea(pt) {
        var ret = false;
        if (pt.x >= sensingArea.x &&
            pt.y >= sensingArea.y &&
            pt.x <= sensingArea.x + sensingArea.width &&
            pt.y <= sensingArea.y + sensingArea.height) {
            ret = true;
        }
        return ret;
    }

    Component {
        id : mouseAreaBuilder
        MouseArea {
            propagateComposedEvents : true
            anchors.fill: parent
            onPressed: {
                mouse.accepted = false;
                var pt = mapToItem(sensingArea,mouse.x,mouse.y)
                if (!inSensingArea(pt))
                    component.pressed();
            }
        }
    }

    Component.onCompleted: setupMouseArea();
    Component.onDestruction: {
        if (_mouseArea)
            _mouseArea.destroy();
    }


}
