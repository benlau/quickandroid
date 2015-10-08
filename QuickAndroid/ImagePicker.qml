import QtQuick 2.0
import QuickAndroid 0.1

Item {

    /// If it is true, it will broadcast the taked photo to other application (e.g Let it show in Google Photos)
    property bool broadcast: true

    property string imageUrl: ""

    signal ready();

    function pickImage() {
        SystemDispatcher.dispatch(m_PICK_IMAGE_MESSAGE,{});
    }

    function takePhoto() {
        SystemDispatcher.dispatch(m_TAKE_PHOTO_MESSAGE,{
                                      broadcast: broadcast
                                  })
    }

    property string m_PICK_IMAGE_MESSAGE: "quickandroid.ImagePicker.pickImage";
    property string m_PICKED_IMAGE_MESSAGE: "quickandroid.ImagePicker.pickedImage";

    property string m_TAKE_PHOTO_MESSAGE: "quickandroid.ImagePicker.takePhoto";




    Connections {
        target: SystemDispatcher
        onDispatched: {
            if (type === m_PICKED_IMAGE_MESSAGE) {
                imageUrl = message.imageUrl;
                ready();
            }
        }
    }

    Component.onCompleted: {
        SystemDispatcher.loadClass("quickandroid.ImagePicker");
    }
}

