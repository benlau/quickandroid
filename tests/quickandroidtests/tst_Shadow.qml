import QtQuick 2.0
import QtTest 1.0
import "../.."
import "../../drawable"

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
            // Wait until all the UI is already

//            wait(60000);
        }
    }


}
