import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {
    id: demo
    actionBar: ActionBar {
        title: "Image Picker Demo"
        onActionButtonClicked: back();
    }

    ImagePicker {
        id: imagePicker;
        multiple : true
    }

    Rectangle {
        anchors.fill: parent
        color: Constants.black100

        Image {
            id: image
            anchors.fill: parent
            source: imagePicker.imageUrl
            fillMode: Image.PreserveAspectFit
            visible: imagePicker.imageUrls.length <= 1
        }

        Grid {
            columns: 3
            spacing: 0
            visible: !image.visible

            Repeater {
                model: imagePicker.imageUrls
                delegate: Image {
                    width: demo.width / 3
                    height: width / 4 * 3
                    source: modelData
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }

        Column {
            anchors.right: parent.right
            anchors.rightMargin: 16 * A.dp
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 32 * A.dp

            spacing: 16 * A.dp

            FloatingActionButton {
                iconSource: A.drawable("ic_camera",Constants.black87);
                size: Constants.small
                backgroundColor: Constants.white100
                onClicked: {
                    imagePicker.takePhoto();
                }
            }

            FloatingActionButton {
                iconSource: A.drawable("ic_image",Constants.black87);
                size: Constants.small
                backgroundColor: Constants.white100
                onClicked: {
                    imagePicker.pickImage();
                }
            }

        }

    }
}

