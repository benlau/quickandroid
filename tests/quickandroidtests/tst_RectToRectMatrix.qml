import QtQuick 2.3
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : window
    width: 480
    height: 640

    Rectangle {
        id: container
        color : "red"

        width : 200
        height: 200
    }

    Rectangle {
        id : child
        color : "yellow"
        width : 100
        height : 50

        transform: RectToRectMatrix {
            source: Qt.rect(child.x,child.y,child.width,child.height)
            dest: Qt.rect(container.x,container.y,container.width,container.height)
        }
    }

    TestCase {
        name: "RectToRectMatrixTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            var pt = child.mapToItem(container,0,0);
            compare(pt.x , 0);
            compare(pt.y , 50);
            pt = child.mapToItem(container,100,50);
            compare(pt.x , 200);
            compare(pt.y , 150);

            // swap the width and height
            child.width = 50;
            child.height = 100;
            pt = child.mapToItem(container,0,0);
            compare(pt.x , 50);
            compare(pt.y , 0);
            pt = child.mapToItem(container,50,100);
            compare(pt.x , 150);
            compare(pt.y , 200);

            wait(1000);
        }
    }


}
