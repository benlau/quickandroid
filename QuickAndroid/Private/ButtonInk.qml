import QtQuick 2.0

// For use with ButtonStyle
RippleSurface {
    id: surface

    property bool alwaysCenter: false;

    Connections {
        target: control.__behavior
        onPressed: {
            var x = mouse.x;
            var y = mouse.y;
            if (alwaysCenter) {
                x = surface.width / 2
                y = surface.height / 2
            }
            surface.tap(x,y);
        }

        onReleased: {
            surface.clear();
        }

        onCanceled: {
            surface.clear();
        }
    }
}

