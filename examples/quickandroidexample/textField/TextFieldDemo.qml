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

        Control.TextField {
            text: "Default Qt Text Field"
        }

        TextField {
            text: "Text 1 - Default Style"
        }

        TextField {
            text: "Text 2 - Default Style"
            width: parent.width
        }

    }

}

