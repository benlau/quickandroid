import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "../theme"

Activity {

    actionBar: AppActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("Shadow Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10
    }

    ListView {
        anchors.top : parent.top
        anchors.topMargin: 8 * A.dp
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model : 5
        spacing : 16 * A.dp
        delegate : Item {
            width: parent.width
            height: childrenRect.height

            MaterialShadow {
                anchors.fill: whiteFrame
                depth: modelData + 1
                asynchronous: true
            }

            Rectangle {
                id: whiteFrame
                color : "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
                width: 96 * A.dp
                height: 96 * A.dp
            }

            Text {
                anchors.top : whiteFrame.bottom
                anchors.topMargin: 8 * A.dp
                anchors.horizontalCenter: parent.horizontalCenter
                text : "Depth : " + (modelData + 1)
                font.pixelSize: Style.theme.largeText.textSize * A.dp
                color : Style.theme.black87

            }

        }

    }

}
