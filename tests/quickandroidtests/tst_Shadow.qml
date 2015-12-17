import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    anchors.fill: parent
    color : "#eeeeee"

    Grid {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 10

        Repeater {
            model : 5
            delegate: Item {

                width: 100
                height: 100

                MaterialShadow {
                    asynchronous: true
                    anchors.fill: card
                    depth: modelData + 1
//                    shader: true
                }

                Rectangle {
                    id : card
                    anchors.fill: parent
                }

            }
        }

    }

    TestCase {
        name: "ShadowTests"
        width : 800
        height : 480
        when : windowShown

        function test_basic() {
            wait(TestEnv.waitTime);
        }
    }


}
