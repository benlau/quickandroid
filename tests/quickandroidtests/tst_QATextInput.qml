import QtQuick 2.0
import QtQuick 2.0 as Quick

import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.drawable 0.1
import QuickAndroid.priv 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        y: 10
        spacing : 8

        QATextInput {
            x: 100
            id : textInput1
            width: 100
            height: 40
            text: "Text Input 1......................................"
            style.textStyle.textSize: 20
        }

        QATextInput {
            x: 100
            id : textInput2
            width: 150
            height: 40
            text: "Text Input 2......................................."
            gravity: "bottom"
            background: "qrc:///QuickAndroid/drawable/TextFieldSearchHoloLight.qml"
            style.textStyle.textColor: "red"
        }

        Quick.Text {
            id: text1
            x: 100
            text: "Large Text"
            TextBehaviour {
                textStyle: ThemeManager.currentTheme.largeText
                shrink: true
            }
        }

        Quick.Text {
            id: text2
            x: 100
            width: 100
            text: "Large Text"
            TextBehaviour {
                textStyle: ThemeManager.currentTheme.largeText
                shrink: true
            }
        }
    }

    TestCase {
        name: "QATextInputTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            console.log(textInput1.textInput.implicitWidth,textInput1.flickable.contentX);
//            wait(60000);
        }

        function test_shrink() {
            compare(text1.contentWidth,text2.contentWidth)
            compare(text2.scale !== 1,true);
//            wait(60000);

        }
    }

}
