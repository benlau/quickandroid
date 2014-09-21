import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.drawable 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        y: 10
        QATextInput {
            x: 100
            id : textInput1
            width: 100
            height: 40
            text: "Text Input 1......................................"
            z: 100

        }

        QATextInput {
            x: 100
            id : textInput2
            width: 100
            height: 40
            text: "Text Input 2......................................."
            z: 99
        }

    }

    TestCase {
        name: "QATextInputTests"
        width : 480
        height : 480
        when : windowShown

        function test_basic() {
            console.log(textInput1.textInput.implicitWidth,textInput1.flickable.contentX);
            wait(60000);
        }
    }

}
