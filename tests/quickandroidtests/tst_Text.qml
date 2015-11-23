import QtQuick 2.0
import QtQuick 2.0 as Quick

import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    width: 480
    height: 640

    VisualItemModel {
        id: visualModel
        Text {
            id : text0
            text: "Default Text"
        }

        Text {
            id : text1
            text: "Small Text"
            type: Constants.smallText
        }

        Text {
            id: text2
            text: "Normal Text"
            type: Constants.normalText
        }

        Text {
            id: text3
            text: "Medium Text"
            type: Constants.mediumText
        }

        Text {
            id: text4
            text: "Large Text"
            type: Constants.largeText
        }

        Text {
            id: text5
            text: "Custom Text"
            material: TextMaterial {
                textSize: 20
                textColor : "blue"
            }
        }

        Text {
            // Set color directly
            id : text6
            text: "Custom Text 2"
            color : "red"
        }

        Text {
            // Set color directly
            id : text7
            text: "Custom Text 3"            
            color : "green"
        }

        Text {
            id: text8
            text: "Normal Disabled Text"
            enabled: false
        }

        Text {
            id: text9
            text: "Bold Text"
            material: TextMaterial {
                bold: true
            }
        }

        Quick.Text {
            id : dummy
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
        name: "TextTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            compare(text0.font.pixelSize , 16);
            compare(text1.font.pixelSize , 14);
            compare(text2.font.pixelSize , 16); // Normal size
            compare(text3.font.pixelSize , 18);
            compare(text4.font.pixelSize , 22);
            compare(text5.font.pixelSize , 20);
            compare(text5.color , "#0000ff");
            compare(text6.color , "#ff0000");
            compare(text7.color , "#008000");
            compare(text7.font.pixelSize , 16);

            wait(TestEnv.waitTime);
        }
    }
}

