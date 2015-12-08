import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

ButtonStyle {

    id: style

    padding.left: 0
    padding.right: 0
    padding.top: 0
    padding.bottom: 0

    property var _control : control

    background: Loader {
        property var control: style._control
        sourceComponent: control.background
    }

    label: Item {
        id: item
        implicitWidth: Math.max(36 * A.dp, label.width + 32 * A.dp);
        implicitHeight: 36 * A.dp
        anchors.centerIn: parent

        Image {
            id: icon
            source: control.iconSource
            sourceSize: control.iconSourceSize
            visible: control.iconSource !== null
            anchors.centerIn: parent
            asynchronous: control.asynchronous
            opacity: control.enabled ? 1 : control.material.disabledOpacity
        }

        Text {
            id: label
            anchors.centerIn: parent
            text: control.text
            material: TextMaterial {
                textColor: control.textColor
                textSize: control.textSize
                bold: control.material.text.bold
                disabledTextColor: control.material.text.disabledTextColor
            }
        }

        states: [
            State {
                name: "IconOnly"
                when: String(control.iconSource).length !== 0 && control.text.length === 0

                PropertyChanges {
                    target: item
                    implicitWidth: 48 * A.dp
                    implicitHeight: 48 * A.dp
                }
            },

            State {
                name: "IconAndText"
                when: String(control.iconSource).length !== 0 && control.text.length !== 0

                PropertyChanges {
                    target: icon
                    anchors.centerIn: undefined
                    anchors.verticalCenter: item.verticalCenter
                    anchors.left: item.left
                    anchors.leftMargin: 8 * A.dp
                }

                PropertyChanges {
                    target: label
                    anchors.centerIn: undefined
                    anchors.verticalCenter: item.verticalCenter
                    anchors.right: item.right
                    anchors.rightMargin: 8 * A.dp
                }

                PropertyChanges {
                    target: item
                    implicitWidth: Math.max(36 * A.dp, icon.width + label.width + 16 * A.dp);
                    implicitHeight: 48 * A.dp
                }
            }

        ]
    }
}

