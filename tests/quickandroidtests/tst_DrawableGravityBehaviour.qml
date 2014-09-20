import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.drawable 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Drawable {
        id: drawable
        width: 600
        height: 400
        property alias gravity: gravityBehaviour.gravity
        source: Item {

            implicitWidth: 300
            implicitHeight: 200

            property alias fillArea: fillAreaItem
            Item {
                id: fillAreaItem
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.topMargin: 20
                anchors.rightMargin: 30
                anchors.bottomMargin: 40
            }
        }


        content : Item {
            id: childrenItem
            width: 200
            height: 100
        }

//        Item { id : childrenItem }

        DrawableGravityBehaviour {
            id: gravityBehaviour
        }

    }

    TestCase {
        name: "DrawableGravityBehaviourTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            compare(drawable.gravity,"center"); // It is the default value
            drawable.gravity = "center";

            compare(childrenItem.width  , 200);
            compare(childrenItem.height , 100);
            compare(childrenItem.x, (600 - 40 - 200 ) / 2);
            compare(childrenItem.y, (400 - 60 - 100 ) / 2);

            drawable.gravity = "left";
            compare(childrenItem.x,0);
            compare(childrenItem.y, (400 - 60 - 100 ) / 2);

            drawable.gravity = "right";
            compare(childrenItem.x,600 - 40 - 200);
            compare(childrenItem.y, (400 - 60 - 100 ) / 2);

            drawable.gravity = "top";
            compare(childrenItem.x, (600 - 40 - 200 ) / 2);
            compare(childrenItem.y, 0);

            drawable.gravity = "bottom";
            compare(childrenItem.x, (600 - 40 - 200 ) / 2);
            compare(childrenItem.y, 400 - 60 - 100);
        }
    }

}
