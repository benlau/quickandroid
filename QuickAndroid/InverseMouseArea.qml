/**
    Author : Ben Lau (@benlau)
    License: Apache
 */

import QtQuick 2.0
import QuickAndroid 0.1

Item {
    id : component

    property Item sensingArea : null

    signal pressed

    property var _mouseArea : null

    function _setupMouseArea() {
        if (!_mouseArea) {
            _mouseArea = mouseAreaBuilder.createObject(component);
        }
        var p = sensingArea;
        if (!p)
            p = _topMostItem();
        _mouseArea.parent = p;
    }

    function _destroyMouseArea() {
        if (_mouseArea) {
            _mouseArea.destroy();
            _mouseArea = null;
        }
    }

    function _inBound(pt) {
        var ret = false;
        if (pt.x >= component.x &&
            pt.y >= component.y &&
            pt.x <= component.x + component.width &&
            pt.y <= component.y + component.height) {
            ret = true;
        }
        return ret;
    }

    function _topMostItem() {
        var p = component;

        while (p.parent) {
            p = p.parent;
        }
        return p;
    }

    Component {
        id : mouseAreaBuilder
        MouseArea {
            propagateComposedEvents : true
            anchors.fill: parent
            z: Constants.zInverseMouseArea
            onPressed: {
                mouse.accepted = false;
                var pt = mapToItem(component.parent,mouse.x,mouse.y)
                if (!_inBound(pt))
                    component.pressed();
            }
        }
    }

    onEnabledChanged:  {
        _destroyMouseArea();
        if (enabled) {
            _setupMouseArea();
        }
    }

    Component.onCompleted: {
        if (enabled)
            _setupMouseArea();
    }

    Component.onDestruction: {
        _destroyMouseArea();
    }

}
