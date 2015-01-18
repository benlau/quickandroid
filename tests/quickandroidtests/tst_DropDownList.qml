import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    ListModel {
        id : listModel

        ListElement {
            title : "Apple"
        }

        ListElement {
            title : "Banana"
        }

        ListElement {
            title : "Cinnamon"
        }

    }

    DropDownList {
        id : dropDownList
        x: 0
        y : 0
        model : listModel
    }

    TestCase {
        name: "DropDownListTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);
            compare(dropDownList.currentIndex,-1);
            // Click the second button
            mouseClick(rect,100,100);
            compare(dropDownList.currentIndex,1);

            wait(TestEnv.waitTime);
        }
    }


}
