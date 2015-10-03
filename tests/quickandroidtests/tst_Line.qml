import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Private 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        Line {
            width: parent.width
            height: 48
        }

        Line {
            width: parent.width
            height: 48
            penWidth: 2
            penStyle: Line.DotLine;
            color: "red"
        }

        Row {
            width: parent.width
            height: 48

            Line {
                orientation: Qt.Vertical
                width: 48
                height: 48
                penWidth: 5
                penStyle: Line.DashDotLine
                color: "green"
            }

        }
    }


    TestCase {
        name: "LineTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            wait(TestEnv.waitTime);
        }
    }


}
