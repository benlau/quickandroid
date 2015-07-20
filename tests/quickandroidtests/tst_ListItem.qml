import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1
import QuickAndroid.item 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent
        ListItem {
            title : "Item 1"
            dividerLeftInset: 45
            dividerRightInset: 30
        }

        ListItem {
            title : "Item 2 - 12345678901234567890123456789012345678901234567890"
            value : "Value"
        }

        ListItem {
            iconSource: Qt.resolvedUrl("img/ic_action_accept.png")
            title: "Item 3"
            value : "Value"
            z:1
        }

        ListItem {
            icon : Rectangle {
                width: 56
                height: 32
                color : "red"
                anchors.verticalCenter: parent.verticalCenter
            }

            rightIcon : Rectangle {
                width: 32
                height: 32
                color : "red"
                anchors.verticalCenter: parent.verticalCenter
            }


            title: "Custom Icon and Value"
        }

        ListItem {
            title : "Item 5"
            subtitle : "Subtitle"
            value : "Value"
        }
    }

    Rectangle {
        height: rect.height
        width: 1
        color : "red"
        x: 16
    }

    Rectangle {
        height: rect.height
        width: 1
        color : "red"
        x: 72
    }

    Rectangle {
        height: rect.height
        width: 1
        color : "red"
        x: parent.width - 16
    }

    TestCase {
        name: "ListItemTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            wait(TestEnv.waitTime);
        }
    }


}
