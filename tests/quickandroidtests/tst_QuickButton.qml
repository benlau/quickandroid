import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Rectangle {
    id : window

    width: 480
    height: 640
    Component {
        id : buttonCreator
        QuickButton {
            id: button
            text: "Test Button"
            x: 10
            y: 10
            width: 100
            height: 50
        }
    }


    TestCase {
        name: "QuickButton"
        width : 480
        height : 480
        when : windowShown

        function test_setBackgoundTwice() {
            var button = buttonCreator.createObject(window);
            var fillArea = button.fillArea;

            // The background is already by default. Now try to change it.
//            button.background = "qrc:/QuickAndroid/drawable/BtnDefault.qml"
            button.background = "qrc:/QuickAndroid/drawable/ItemBackgroundHoloLight.qml"

            fillArea = button.fillArea;

            compare(fillArea.width ,100)
            compare(fillArea.height ,50)
//            wait(TestEnv.waitTime);

            wait(200);
            compare(fillArea.width ,100)
            compare(fillArea.height ,50)

            wait(TestEnv.waitTime);
            button.destroy();
        }
    }
}

