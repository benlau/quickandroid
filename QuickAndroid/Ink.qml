import QtQuick 2.0
import QuickAndroid 0.1
import "./Private"

MouseArea {
    id: ink

    RippleSurface {
        id: surface;
        anchors.fill: parent
    }

    onPressed: {
        surface.tap(mouse.x,mouse.y);
    }

    onReleased: {
        surface.clear();
    }

    onCanceled: {
        surface.clear();
    }

}

