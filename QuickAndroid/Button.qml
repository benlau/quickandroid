import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Controls.Styles 1.2 as ControlsStyles
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "./drawable"

/// Base Button Component

Controls.Button {

    id: button

    property var background : Style.theme.button.background

    property color textColor: Style.theme.button.textStyle.textColor

    property int textSize: Style.theme.button.textStyle.textSize

    implicitHeight: 48 * A.dp

    style: ControlsStyles.ButtonStyle {
        padding.left: 8 * A.dp
        padding.right: 8 * A.dp
        padding.bottom: 0
        padding.top: 0

        background: StateListDrawable {
            // Ignore the fill area@ Material Design
            implicitHeight: 36 * A.dp
            implicitWidth: 64 * A.dp
            source: Qt.resolvedUrl("./drawable/BtnDefault.qml");
            pressed: control.pressed
        }

        label: Item {
            implicitWidth: Math.max(36 * A.dp, label.width + 16 * A.dp);
            height: 48 * A.dp

            Text {
                id: label
                anchors.centerIn: parent
                text: control.text
                textStyle: TextStyle {
                    textColor: button.textColor
                    textSize: button.textSize
                }
            }
        }
    }
}

