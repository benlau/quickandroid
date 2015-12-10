import QtQuick 2.0
import QuickAndroid 0.1
import "./Private"

MouseArea {
    id: ink
    clip: true

    property color color: Constants.black12

    RippleSurface {
        id: surface;
        color: ink.color
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

