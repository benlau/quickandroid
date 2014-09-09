import QtQuick 2.2
import "qrc:/quickandroid"

Application {
    width: 480
    height: 640
    icon : Qt.resolvedUrl("drawable-hdpi/icon.png")

    Component.onCompleted: {
        start(Qt.resolvedUrl("Components.qml"));
    }

}
