// Construct a Matrix4x4 to scale and translate values that map the source rectangle to the destination rectangle
import QtQuick 2.3

Matrix4x4 {
    property rect source;
    property rect dest;
    property real scale : 1;
    property var offset

    onSourceChanged: calc();
    onDestChanged: calc();

    function identityMatrix() {
        return Qt.matrix4x4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
    }

    function scaleMatrix(factor){
        var t = Qt.matrix4x4(factor,0,0,0,
                              0,factor,0,0,
                              0,0,1,0,
                              0,0,0,1);
        return t;
    }

    function translateMatrix(dx,dy) {
        var t = Qt.matrix4x4(1,0,0,dx,
                             0,1,0,dy,
                             0,0,1,0,
                             0,0,0,1);
        return t;
    }

    function calc() {
        // Only scaleToFit mode is supported now.
        scale = 1;

        if (source.width <= 0 ||
            source.height<= 0 ||
            dest.width <=0 ||
            dest.height <=0) {
            matrix = identityMatrix();
            return;
        }

        var ratio = source.height / source.width
        if (dest.width * ratio > dest.height) {
            // fit on height
            scale = dest.height / source.height;
        } else {
            scale =  dest.width / source.width;
        }

        var dw = source.width * scale;
        var dh = source.height * scale;

        var dx = (dest.width - dw) / 2
        var dy = (dest.height - dh) / 2;

        offset = Qt.point(dx,dy);
        matrix = translateMatrix(dx,dy).times(scaleMatrix(scale));
    }
}
