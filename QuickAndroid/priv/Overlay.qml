// A special component that will be placed on the top of the scene instead of current scope.
import QtQuick 2.0
//import QuickAndroid 0.1
import "../global.js" as Global

Item {
    z: 100000
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

        if (!parent.parent) // It is topmost component alreaddy
            return;

        var p = parent;
        while (p.parent) {
            p = p.parent;
        }

        parent = p;
    }

    onParentChanged: placeToTop();
    Component.onCompleted: placeToTop();

}
