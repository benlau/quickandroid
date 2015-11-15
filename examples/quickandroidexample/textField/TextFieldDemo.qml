import QtQuick 2.0
import QtQuick.Controls 1.3 as Control
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Page {

    actionBar: ActionBar {
        title: "TextField Demo"
        onActionButtonClicked: back();
    }

    Control.ScrollView {
        id: scrollView
        anchors.fill: parent

        Column {
            x: 16 * A.dp
            width: scrollView.width - 32 * A.dp
            spacing: 8 * A.dp

            TextField {
                text: ""
                width: parent.width
            }

            TextField {
                placeholderText: "TextField with Placeholder Text"
                width: parent.width
            }

            TextField {
                floatingLabelText: "Floating Label Text"
                width: parent.width
            }

            TextField {
                floatingLabelText: "Floating Label Text with Placeholder Text"
                width: parent.width
                placeholderText: "Placeholder Text"
            }

            TextField {
                text: "Disabled TextField"
                width: parent.width
                enabled: false
            }

            TextField {

                height: 48 * A.dp
                width: parent.width
                placeholderText: "TextMaterial with plain style"

                style: TextFieldPlainStyle {

                }
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

}

