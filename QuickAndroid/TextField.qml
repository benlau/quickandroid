import QtQuick 2.0
import QtQuick.Controls 1.2 as Control
import QtQuick.Controls.Styles 1.3 as ControlSyles
import QuickAndroid.Styles 0.1
import QuickAndroid 0.1
import QuickAndroid.Private 0.1
import "./Private"

Control.TextField {
    height: 48 * A.dp

    property TextFieldStyle aStyle: ThemeManager.currentTheme.textField

    property color color: aStyle.color

    FloatingPasteButton {
        id: pasteButton
        onClicked: paste();
    }

    MouseSensor {
        anchors.fill: parent
        enabled: canPaste
        onPressAndHold: {
            pasteButton.openAt(cursorRectangle);
        }
        z: 10000
    }

    style: ControlSyles.TextFieldStyle {
        padding.top: 16 * A.dp
        padding.bottom: 16 * A.dp
        padding.left: 0
        padding.right: 0

        font {
            pixelSize: enabled ? aStyle.textStyle.textSize : aStyle.disabledTextStyle.textSize
        }
        textColor:  enabled ?  aStyle.textStyle.textColor : aStyle.disabledTextStyle.textColor

        background: Item {

            Rectangle {
                id: inactiveUnderline
                height: 1 * A.dp
                color: control.aStyle.inactiveColor
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8 * A.dp
                visible: enabled
            }

            Rectangle {
                id: activeUnderline
                height: 2 * A.dp
                color: control.color
                width: control.activeFocus ? parent.width : 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8 * A.dp
                anchors.horizontalCenter: parent.horizontalCenter
                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutSine
                    }
                }
            }

            Line {
                height: 2 * A.dp
                penWidth: 1 * A.dp
                width: parent.width
                visible: !enabled
                color: control.aStyle.disabledColor
                penStyle: Line.DotLine
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8 * A.dp
            }
        }

        property Component __selectionHandle: Image {
            source:  Qt.resolvedUrl("./drawable-xxhdpi/text_select_handle_left.png")
            sourceSize : Qt.size(96 * A.dp, 88 * A.dp)
            x: -width / 4 * 3
            y: styleData.lineHeight
        }

        property Component __cursorHandle: Image {
            source: styleData.hasSelection ? Qt.resolvedUrl("./drawable-xxhdpi/text_select_handle_right.png")
                      : Qt.resolvedUrl("./drawable-xxhdpi/text_select_handle_middle.png")
            sourceSize : Qt.size(96 * A.dp, 88 * A.dp)
            x: styleData.hasSelection ? -width / 4 : -width / 2
            y: styleData.lineHeight
        }
    }
}

