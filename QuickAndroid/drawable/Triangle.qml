// Show a triangle by pure QML
import QtQuick 2.0

Item {
    id : component
    width: 100
    height: 100
    clip : true

    // The index of corner for the triangle to be attached
    property int corner : 0;
    property alias color : rect.color

    Rectangle {
        x : component.width * ((corner+1) % 4 < 2 ? 0 : 1) - width / 2
        y : component.height * (corner    % 4 < 2 ? 0 : 1) - height / 2
        id : rect
        color : "red"
        antialiasing: true
        width : Math.min(component.width,component.height)
        height : width
        transformOrigin: Item.Center
        rotation : 45
        scale : 1.414
    }
}
