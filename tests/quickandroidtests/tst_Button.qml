import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        Button {
            id:button1
            text: "Button 1"

            property int pressAndHoldCount: 0;

            onPressAndHold: {
                pressAndHoldCount++;
            }
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
            iconSourceSize: Qt.size(16 * A.dp,16 * A.dp)
            text: "Icon and Text"
        }

        Button {
            id: button5
            text: "Icon and Text"
            textColor: Constants.white100
            background: DarkButtonBackground {
            }
        }

        RaisedButton {
            id: button6
            text: "Raised Button"
            textColor: Constants.white100
        }

    }

    TestCase {
        name: "ButtonTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            compare(button1.height,36);
            compare(button2.height,36);

            compare(button3.height,48);
            compare(button3.width,48);

            compare(button4.height,48);

            compare(button5.height,36);

            wait(TestEnv.waitTime);
        }

        function test_pressAndHold() {
            button1.pressAndHoldCount = 0;
            mousePress(button1);
            compare(button1.pressAndHoldCount,0);
            wait(100);
            compare(button1.pressAndHoldCount,0);
            wait(810);
            compare(button1.pressAndHoldCount,1);

            // Prove the timer is already stopped
            wait(800);
            compare(button1.pressAndHoldCount,1);
            mouseRelease(button1);
            wait(800);
            compare(button1.pressAndHoldCount,1);
            mouseRelease(button1);

            // Try again
            mousePress(button1);

            wait(100);
            compare(button1.pressAndHoldCount,1);
            wait(850);
            compare(button1.pressAndHoldCount,2);
            mouseRelease(button1);
            wait(850);
            compare(button1.pressAndHoldCount,2);
        }
    }


}
