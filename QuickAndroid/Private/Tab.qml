import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Item {
    id: tab

    property string title

    property string iconSource

    property color tintColor: "#fff"

    property bool active: false

    property color colorPressed : Constants.black12

    signal clicked

    height: 48 * A.dp

    opacity: tab.active ? 1 : 0.7

    Ink {
        id: mouseArea
        color: colorPressed
        anchors.fill: parent
        onClicked: {
            tab.clicked();
        }
    }

    Image {
        id: icon
        source: iconSource
        anchors.horizontalCenter: parent.horizontalCenter
        sourceSize: Qt.size(24 * A.dp , 24 * A.dp)
    }

    Text {
        id: label
        text: title
        gravity: "center"
        width: tab.width - 12 * A.dp
        maximumLineCount: 2
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        color: tab.tintColor
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    state: "textOnly"
    states: [
        State {
            name: "textOnly"
            when: title && !iconSource

            PropertyChanges {
                target: tab
                height: 48 * A.dp
            }

            PropertyChanges {
                target: label
                anchors.centerIn: tab
                font.pixelSize: 14 * A.dp
            }
        },
        State {
            name: "textAndIcon"
            when: iconSource && title

            PropertyChanges {
                target: tab
                height: 72 * A.dp
            }

            PropertyChanges {
                target: label
                anchors.bottom: tab.bottom
                anchors.bottomMargin: 16 * A.dp
                font.pixelSize: 14 * A.dp
            }

            PropertyChanges {
                target: icon
                anchors.bottom: label.top
                anchors.bottomMargin: 10 * A.dp
            }
        },
        State {
            name: "iconOnly"
            when: iconSource && !title

            PropertyChanges {
                target: tab
                height: 48 * A.dp
            }

            PropertyChanges {
                target: icon
                anchors.centerIn: tab
            }

        }

    ]

}
