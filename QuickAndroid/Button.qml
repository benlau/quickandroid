import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlsStyles
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./drawable"

/// Base Button Component

Controls.Button {

    id: button

    property size iconSourceSize

    property var background : Style.theme.button.background

    property color textColor: Style.theme.button.textStyle.textColor

    /// The text size in sp unit
    property int textSize: Style.theme.button.textStyle.textSize

    style: ControlsStyles.ButtonStyle {

        padding.left: 0
        padding.right: 0
        padding.top: 0
        padding.bottom: 0

        background: StateListDrawable {

            // Ignore the fill area@ Material Design
            implicitHeight: 36 * A.dp
            implicitWidth: 36 * A.dp
            source: control.background
            pressed: control.pressed
        }

        label: Item {
            id: item
            implicitWidth: Math.max(36 * A.dp, label.width + 16 * A.dp);
            implicitHeight: 48 * A.dp
            anchors.centerIn: parent

            Image {
                id: icon
                source: control.iconSource
                sourceSize: control.iconSourceSize
                visible: control.iconSource !== null
                anchors.centerIn: parent
            }

            Text {
                id: label
                anchors.centerIn: parent
                text: control.text
                textStyle: TextStyle {
                    textColor: button.textColor
                    textSize: button.textSize
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
}

