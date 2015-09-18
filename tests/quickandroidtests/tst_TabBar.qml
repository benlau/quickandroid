import QtQuick 2.0
import QtTest 1.0
import QuickAndroid 0.1

Rectangle {
    id : rect
    width: 480
    height: 640

    Column {
        anchors.fill: parent

        TabBar {
            anchors {
                left: parent.left
                right: parent.right
            }

            tabs: [
                {
                    title: "TAB A"
                },
                {
                    title: "TAB B"
                },
                {
                    title: "TAB C"
                }
            ]
        }

        TabBar {
            anchors {
                left: parent.left
                right: parent.right
            }


            tabs: [
                {title: "TAB A"},
                {title: "TWO LINED TAB - 123456789ABCDEFGHIJKLMNOPQ"},
                {title: "TAB C"},
            ]
        }

        TabBar {
            id: tabs3
            anchors {
                left: parent.left
                right: parent.right
            }

            tabs: [
                {
                    title: "TAB A",
                    iconSource : "qrc:///drawable-hdpi/ic_done_black_24dp.png"
                },
                {
                    title: "TWO LINED TAB - 123456789ABCDEFGHIJKLMNOPQ"
                },
                {
                    title: "TAB C"
                }
            ]
        }

        TabBar {
            id: tabs4
            anchors {
                left: parent.left
                right: parent.right
            }

            tabs: [
                {
                    iconSource : "qrc:///drawable-hdpi/ic_done_black_24dp.png"
                },
                {
                    iconSource : "qrc:///drawable-hdpi/ic_done_black_24dp.png"
                },
                {
                    title: "TAB C"
                }
            ]
        }

    }


    TestCase {
        name: "TabBarTests"
        width : 480
        height : 480
        when : windowShown

        function test_preview() {
            wait(200);

            wait(TestEnv.waitTime);

            compare(tabs3.height, 72 * A.dp)
        }
    }


}
