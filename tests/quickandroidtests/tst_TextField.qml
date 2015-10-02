import QtQuick 2.0
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3
import QuickAndroid 0.1
import QtTest 1.0

Rectangle {
    width: 480
    height: 640

    VisualItemModel {
        id: visualModel

        Controls.TextField {
            id: text1
            text: "Text 1"
            width: 400
        }

        TextField {
            id: text2
            text: "Text 2"
            width: 400

            Ruler {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 10
                orientation: Qt.Vertical
                height: 16
            }

            Ruler {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 100
                orientation: Qt.Vertical
                height: 8
            }

            Ruler {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 120
                orientation: Qt.Vertical
                height: parent.height
            }

        }


        TextField {
            id: text3
            width: 400
            text: "Disabled"
            enabled: false
        }

        TextField {
            id : text4
            width: 400
            placeholderText: "Placeholder text"
        }

        TextField {
            id: text5
            width: 400
            floatingLabelText: "Floating Label"
        }

        TextField {
            id: text6
            width: 400
            floatingLabelText: "Floating Label"
            placeholderText: "Placeholder Text"
        }

    }

    Column {
        x: 10
        y: 10
        spacing: 30

        Repeater {
            model: visualModel
        }
    }


    TestCase {
        name: "TextFieldTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            compare(text2.height, 48);
            compare(text4.height, 48);
            compare(text5.height, 72);

            wait(TestEnv.waitTime);
        }
    }
}

