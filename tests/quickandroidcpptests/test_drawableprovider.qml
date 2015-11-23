import QtQuick 2.0
import QtQuick.Window 2.0
import QuickAndroid 0.1

Window {
    visible: true
    width: 640
    height: 480

    Grid {

        Image {
            objectName : "image1"
            source: 'image://drawable/icon.png'
        }

        Image {
            objectName : "image2"
            source: 'image://drawable/ic_menu.png'
        }

        Image {
            objectName : "image3"
            source: 'image://drawable/Qt-logo-medium.png'
            width: 100
            height: 100
        }

        Image {
            objectName : "image4"
            source: 'image://drawable/icon.png'
            sourceSize: Qt.size(32,32);
        }
    }

}

