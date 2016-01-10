import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Drawable {
        id : drawable
        source : Qt.resolvedUrl("./drawable/MenuDropdownPanelHoloLight.qml")

        DrawableGrowBehaviour {
            id : behaviour
        }
    }

    Drawable {
        id : drawable2
        x: 150
        source : Qt.resolvedUrl("./drawable/MenuDropdownPanelHoloLight.qml")


        DrawableGrowBehaviour {
        }

        content: Rectangle {
            x: 10
            y: 10
            width: 100
            height: 100
        }
    }

    Component {
        id : rectangle
        Rectangle {
            x : 0
            y : 0
            width: 100
            height: 120
        }
    }

    TestCase {
        name: "DrawableGrowBehaviorTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            // For initialization
            wait(100);

            // Original size
            compare(drawable.implicitWidth,64);
            compare(drawable.implicitHeight,32);
            compare(drawable.fillArea.x,8);
            compare(drawable.fillArea.y,8);
            compare(drawable.fillArea.width,48);
            compare(drawable.fillArea.height,16);

            compare(behaviour._fillAreaRightMargin,8);
            compare(behaviour._fillAreaBottomMargin,8);

            var rect = rectangle.createObject();
            drawable.content = rect;
            wait(100);
            compare(drawable.implicitWidth,116);
            compare(drawable.implicitHeight,136);
            compare(behaviour._fillAreaRightMargin,8);
            compare(behaviour._fillAreaBottomMargin,8);
        }
    }


}
