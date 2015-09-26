import QtQuick 2.0
import QtQuick.Controls 1.3 as Control
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Activity {

    actionBar: ActionBar {
        title: "TextField Demo"
        onActionButtonClicked: back();
    }

    Column {
        anchors.fill: parent
        anchors.leftMargin: 16 * A.dp
        anchors.rightMargin: 16 * A.dp
        spacing: 16 * A.dp

        TextField {
            text: ""
            width: parent.width
        }

        TextField {
            placeholderText: "TextField with placeholder text"
            width: parent.width
        }

        TextField {
            text: "Disabled TextField"
            width: parent.width
            enabled: false
        }

        Item {
            height: 48 * A.dp
            width: parent.width
        }

        Control.TextField {
            text: "Qt Default TextField"
            width: parent.width
        }

        Control.TextField {
            text: "Qt Default TextField [Disabled]"
            width: parent.width
            enabled: false
        }


    }

}

