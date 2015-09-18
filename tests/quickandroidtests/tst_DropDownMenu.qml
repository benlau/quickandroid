import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : window
    width: 480
    height: 640

    Button {
        id: button1
        text: "Launch"
        x: 200
        y: 500

        onClicked: {
            dropDownMenu1.open();
        }

        DropDownMenu {
            id: dropDownMenu1
            anchorPoint: Constants.rightTop

            model: VisualItemModel {
                ListItem { title: "Item A - 1234567890"; id: item1 }
                ListItem { title: "Item B" }
                ListItem { title: "Item C" }
                ListItem { title: "Item D" }
                ListItem { title: "Item E" }
            }
        }
    }


    TestCase {
        name: "DropDownMenuTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);
            dropDownMenu1.open();
            wait(TestEnv.waitTime);
        }
    }


}
