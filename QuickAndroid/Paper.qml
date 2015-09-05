/* A white rectangle with shadow
 */
import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    id: paper
    color: "#ffffff"

    property alias depth: shadow.depth
    property alias shader : shadow.shader
    default property alias content: container.children

    MaterialShadow {
        id: shadow
        anchors.fill: parent
        z: -1
    }

    Item {
        id: container
        anchors.fill: parent
    }
}

