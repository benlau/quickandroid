import QtQuick 2.0
import QuickAndroid 0.1

Item {

    id: rippleSurface

    property color color : Constants.black12

    property real minRadius: 24 * A.dp

    property real maxRadius : Math.max(rippleSurface.width,rippleSurface.height)

    function tap(x,y) {

        if (_currentRipple) {
            _currentRipple.stop();
        }

        _currentRipple = rippleCreator.createObject(rippleSurface)
        _currentRipple.start(x,y);
    }

    function clear() {
        if (_currentRipple) {
            _currentRipple.stop();
            _currentRipple = null;
        }
    }

    property var _currentRipple : null

    Component {
        id: rippleCreator

        Rectangle {
            id: ripple
            property real centerX : 0
            property real centerY : 0

            function start(x,y) {
                ripple.centerX = x;
                ripple.centerY = y;
                enlargeAnimation.start();
                fadeInAnimation.start();
            }

            function stop() {
                if (fadeInAnimation.running) {
                    fadeInAnimation.onStopped.connect(function() {
                        fadeOutAnimation.start();
                    });
                } else {
                    fadeOutAnimation.start();
                }
            }

            color: rippleSurface.color
            width: radius * 2
            height: radius *2
            radius: 0
            opacity: 0
            x: centerX - radius
            y: centerY - radius;


            NumberAnimation {
                id: enlargeAnimation
                target: ripple
                property: "radius"
                duration: 500
                from: minRadius
                to: maxRadius
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                id: fadeInAnimation
                target: ripple
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                id: fadeOutAnimation
                target: ripple
                property: "opacity"
                duration: 200
                to: 0
                easing.type: Easing.InOutQuad
                onStopped: {
                    ripple.destroy();
                }
            }
        }
    }


}

