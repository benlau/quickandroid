import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Activity {
    actionBar: ActionBar {
        title: "Image Picker Demo"
        onActionButtonClicked: back();
    }

    ImagePicker {
        id: imagePicker;
    }

    Rectangle {
        anchors.fill: parent
        color: Constants.black100

        Image {
            anchors.fill: parent
            source: imagePicker.imageUrl
            fillMode: Image.PreserveAspectFit
        }

        Column {
            anchors.right: parent.right
            anchors.rightMargin: 16 * A.dp
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 32 * A.dp

            spacing: 16 * A.dp

            /*
            FloatingActionButton {
                iconSource: A.drawable("ic_camera",Constants.black87);
                size: Constants.small
                color: Constants.white100
            }
            */

            FloatingActionButton {
                iconSource: A.drawable("ic_image",Constants.black87);
                size: Constants.small
                color: Constants.white100
                onClicked: {
                    imagePicker.pickImage();
                }
            }

        }

    }
}

