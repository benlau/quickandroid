import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : window
    width: 480
    height: 640

    Rectangle {
        x : 50
        y : 50
        width : 300
        height : 300
        color : "black"

        Rectangle {
            x : 10
            y : 10
            width : 200
            height : 150
            color : "red"

            InverseMouseArea {
                anchors.fill: parent
                onPressed: {
                    console.log("Pressed on non-red rectangle");
                }
            }
        }
    }


    TestCase {
        name: "InverseMouseArea"
        when : windowShown

        function test_default() {
//            wait(60000);
        }
    }
}
