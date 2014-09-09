import QtQuick 2.2
import QtQuick.Window 2.1
import "../../"

Window {
    visible: true
    width: 480
    height: 640

    Activity {
        anchors.fill: parent

        Column {
            id : column1
            width: parent.width
            spacing : 8

            Item {
                width : column1.width
                height:  48
                ActionBar {
                    upEnabled: true
                }
            }

            Item {
                width : column1.width
                height:  48
                ActionBar {
                    showTitle: false
                }
            }

        }


    }

}
