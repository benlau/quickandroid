import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        Button {
            id:button1
            text: "Button 1"
        }
        Button {
            id: button2
            text: "Button 2 - 1234567890"
            textColor: "blue"
            textSize: 24
        }

        Button {
            id: button3
            iconSource : "qrc:///drawable-hdpi/ic_done_black_24dp.png"
        }

        Button {
            id: button4
            iconSource : "qrc:///drawable-hdpi/ic_done_black_24dp.png"
            text: "Icon and Text"
        }

    }

    TestCase {
        name: "ButtonTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            compare(button1.height,48);
            compare(button2.height,48);

            compare(button3.height,48);
            compare(button3.width,48);

            compare(button4.height,48);

            wait(TestEnv.waitTime);
        }
    }


}
