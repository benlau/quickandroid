// A special component that will be placed on the top of the scene instead of current scope.
/*
   Project: Quick Android
   Source: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1
import "../global.js" as Global

Item {
    id: overlay
    z: Constants.zPopupLayer
    width: parent.width
    height: parent.height

    function placeToTop() {
        if (Global.application) {
            if (parent !== Global.application) {
                parent = Global.application
            }
            return;
        }

        if (!parent)
            return;

        if (!parent.parent) // It is under the topmost component already
            return;

        var p = parent; // Looking for the topmost component as parent
        while (p.parent) {
            p = p.parent;
        }

        parent = p;
    }

    Component.onCompleted: {
        overlay.placeToTop();
        onParentChanged.connect(placeToTop);
    }

    Component.onDestruction: {
        onParentChanged.disconnect(placeToTop);
    }

}
