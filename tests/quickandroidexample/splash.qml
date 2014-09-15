/* Author: Ben Lau (https://github.com/benlau) */
import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import "theme.js" as Theme

Rectangle {
    id: splash
    objectName : "Splash"
    width: 480
    height: 640
    color: "#000000"

    function init(context) {
        A.init(context);
        Res.load(Theme)
        mainLoader.source = "main.qml"
    }

    Loader { // this component performs deferred loading.
        id: mainLoader
        visible: status == Loader.Ready
        onLoaded: {
            mainLoader.item.width = Qt.binding(function(){
                return splash.width;
            });
            mainLoader.item.height = Qt.binding(function(){
                return splash.height;
            });
        }
        focus : true
    }
}
