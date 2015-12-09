import QtQuick 2.0
import QuickAndroid 0.1

Item {

    function tap(x,y) {

        if (_currentRipple) {
            _currentRipple.stop();
        }

        _currentRipple = rippleCreator.createObject(ink)
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
            property real maxRadius : Math.max(ink.width,ink.height) * 2
            property real centerX : 0
            property real centerY : 0

            function start(x,y) {
                ripple.centerX = x;
                ripple.centerY = y;
                enlargeAnimation.start();
                fadeInAnimation.start();
            }

            function stop() {
                fadeInAnimation.stop();
                fadeOutAnimation.start();
            }

            color: Constants.black12
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
                from: 0
                to: maxRadius
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                id: fadeInAnimation
                target: ripple
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                id: fadeOutAnimation
                target: ripple
                property: "opacity"
                duration: 300
                to: 0
                easing.type: Easing.InOutQuad
                onStopped: {
                    ripple.destroy();
                }
            }
        }
    }


}

