import QtQuick 2.0
import QuickAndroid 0.1

Item {

    /// Set it to true if multiple images should be picked.
    property bool multiple: false

    /// If it is true, it will broadcast the taked photo to other application (e.g Let it show in Google Photos)
    property bool broadcast: true

    /// The URL of the image chosen. If multiple images are picked, it will be equal to the first image.
    property string imageUrl: ""

    /// A list of images chosen
    property var imageUrls: []

    /// It is emitted whatever photo(s) are picked/taken.
    signal ready();

    function pickImage() {
        SystemDispatcher.dispatch(m_PICK_IMAGE_MESSAGE,{ multiple: multiple});
    }

    function takePhoto() {
        SystemDispatcher.dispatch(m_TAKE_PHOTO_MESSAGE,{
                                      broadcast: broadcast
                                  })
    }

    property string m_PICK_IMAGE_MESSAGE: "quickandroid.ImagePicker.pickImage";

    property string m_TAKE_PHOTO_MESSAGE: "quickandroid.ImagePicker.takePhoto";

    property string m_CHOSEN_MESSAGE: "quickandroid.ImagePicker.chosen";


    Connections {
        target: SystemDispatcher
        onDispatched: {
            if (type === m_CHOSEN_MESSAGE) {
                imageUrls = message.imageUrls;
                imageUrl = imageUrls[0];
                ready();
            }
        }
    }

    Component.onCompleted: {
        SystemDispatcher.loadClass("quickandroid.ImagePicker");
    }
}

