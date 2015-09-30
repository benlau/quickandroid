import QtQuick 2.0
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3
import QuickAndroid 0.1
import QuickAndroid.Private 0.1
import QtTest 1.0

Rectangle {
    width: 480
    height: 640

    Rectangle {
        id: rect
        x: 100
        y: 100
        width: 200
        height: 200
        color: "red"

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            property int pressedCount:0;
            property int clickedCount:0;
            property int pressAndHoldCount: 0

            onPressed:  {
                pressedCount++;
            }

            onClicked: {
                clickedCount++;
            }

            onPressAndHold:  {
                pressAndHoldCount++;
            }

        }
    }

    MouseSensor {
        id: sensor
        filter: rect;
        property int pressAndHoldCount: 0

        onPressAndHold: {
            pressAndHoldCount++;
        }
    }

    TestCase {
        name: "MouseSensorTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(100);
            mouseClick(rect,0,0,Qt.LeftButton);
            wait(10);
            compare(mouseArea.pressedCount,1);
            compare(mouseArea.clickedCount,1);
            compare(mouseArea.pressAndHoldCount,0);

            mousePress(rect,0,0,Qt.LeftButton);
            compare(mouseArea.pressAndHoldCount,0);
            wait(1000);
            compare(mouseArea.pressAndHoldCount,1);
            compare(sensor.pressAndHoldCount,1);


            wait(TestEnv.waitTime);
        }
    }
}

