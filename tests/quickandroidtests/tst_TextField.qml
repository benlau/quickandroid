import QtQuick 2.0
import QtQuick.Controls 1.3 as Controls
import QtQuick.Controls.Styles 1.3
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import QtTest 1.0

Rectangle {
    width: 480
    height: 640

    Component {
        id: standardRuler
        Item {
            anchors.fill: parent

            Ruler {
                anchors.bottom: parent.bottom
                x: 0
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
    }

    Component {
        id: floatingLabelRuler

        Item {
            anchors.fill: parent

            Ruler {
                anchors.bottom: parent.bottom
                x: 20
                orientation: Qt.Vertical
                height: 16
                width: 10
            }

            Ruler {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 100
                orientation: Qt.Vertical
                height: 8
            }

            Ruler {
                anchors.top: parent.top
                height: 16 * A.dp
                x: 30
                width: 6
                orientation: Qt.Vertical
            }

        }

    }

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
            placeholderText: "Placeholder text (Text4)"
            placeholderTextColor: Constants.black54
        }

        TextField {
            id: text5
            width: 400
            floatingLabelText: "Floating Label"
        }

        TextField {
            id: text6
            width: 400
            floatingLabelText: "Text6 - Floating Label"
            placeholderText: "Text6 - Placeholder Text"
        }

        TextField {
            id: text7
            width: 400

            placeholderText: "Larger Text Size"

            material: TextFieldMaterial {
                extend: [ThemeManager.currentTheme.textFieldStyle]
                Component.onCompleted: {
                    text.textSize = 32 * A.dp
                }
            }
        }


        TextField {
            id: text8
            width: 400

            floatingLabelText: "Floating Label"
            placeholderText: "Larger Text Size"

            material: TextFieldMaterial {
                Component.onCompleted: {
                    merge(this,ThemeManager.currentTheme.textField);
                    text.textSize = 32 * A.dp
                }
            }
        }

        TextField {
            id: text9
            width: 400
            floatingLabelText: "Floating Label Always on Top"
            floatingLabelAlwaysOnTop: true
        }
    }

    Column {
        x: 10
        y: 10
        spacing: 10

        Repeater {
            model: visualModel
        }
    }


    Component.onCompleted: {
        standardRuler.createObject(text2);
        floatingLabelRuler.createObject(text6);

        standardRuler.createObject(text7);
        floatingLabelRuler.createObject(text8);

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

            // Text 9

            var floatingLabel = Testable.search(text9,"FloatingLabelText");
            compare(floatingLabel.font.pixelSize,12);
            compare(floatingLabel.anchors.bottomMargin > 16,true); // Already on top
            text9.forceActiveFocus();
            wait(1000);
            compare(floatingLabel.color,ThemeManager.currentTheme.colorAccent);


            wait(TestEnv.waitTime);
        }

        function test_text8() {
        }
    }
}

