import QtQuick 2.0
import QuickAndroid 0.1

Item {

    property string m_PICK_IMAGE_MESSAGE: "quickandroid.ImagePicker.pickImage";
    property string m_PICKED_IMAGE_MESSAGE: "quickandroid.ImagePicker.pickedImage";

    property string imageUrl: ""

    function pickImage() {
        SystemDispatcher.dispatch(m_PICK_IMAGE_MESSAGE,{});
    }

    Connections {
        target: SystemDispatcher
        onDispatched: {
            if (type === m_PICKED_IMAGE_MESSAGE) {
                imageUrl = message.imageUrl;
            }
        }
    }

    Component.onCompleted: {
        SystemDispatcher.loadClass("quickandroid.ImagePicker");
    }
}

