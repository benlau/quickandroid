import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Row {

        QuickButton {
            id : button1
            width : 100
            height : 100
            Rectangle {
                anchors.fill: parent
                color : "#10FF0000"
            }
        }

        QuickButton {
            // button with text only
            id : button2
    //        x : 100
            background : "drawable/SpinnerAbHoloLight.qml"
            content: Rectangle {
                width: 20
                height: 26

                Text {
                    id : button2Text
                    text : "A"
                    font.pixelSize: 26
                    anchors.centerIn: parent
                }
            }
        }

        QuickButton {
            id : button3
            icon : Qt.resolvedUrl("drawable-xhdpi/ic_action_accept.png")
        }

        QuickButton {
            id: button4
            width: 200
            height: 100
//            background : "#ffffff"
            text : "Text Button"
        }

    }

    TestCase {
        name: "QuickButtonTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            // Wait until all the UI is already
            wait(500);
            compare(button2.implicitWidth , 20 + 28);
            compare(button2.implicitHeight , 26 + 12);

            console.log(button3.width,button3.height)
            compare(button3.implicitWidth ,48);
            compare(button3.implicitHeight ,48);

//            wait(60000);
        }
    }


}
