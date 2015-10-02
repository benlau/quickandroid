import QtQuick 2.0
import QtQuick.Controls 1.2 as Control
import QtQuick.Controls.Styles 1.3 as ControlSyles
import QuickAndroid.Styles 0.1
import QuickAndroid 0.1
import QuickAndroid.Private 0.1
import "./Private"

Control.TextField {
    id: textField
    height: hasFloatingLabel ? 72 * A.dp : 48 * A.dp

    property TextFieldStyle aStyle: ThemeManager.currentTheme.textField

    property color color: aStyle.color

    property string floatingLabelText: ""
    readonly property bool hasFloatingLabel : floatingLabelText !== ""

    FloatingPasteButton {
        id: pasteButton
        cursorRect: cursorRectangle;
        onClicked: paste();
        item: textField
    }

    MouseSensor {
        enabled: canPaste
        filter: textField
        onPressAndHold: {
            pasteButton.openAt();
        }
        z: 10000
    }

    onTextChanged: pasteButton.close();

    style: ControlSyles.TextFieldStyle {
        id: style
        padding.top: control.hasFloatingLabel ? 40 * A.dp : 16 * A.dp
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

            Text {
                id: floatingLabelTextItem
                aStyle: control.aStyle.textStyle
                enabled: false
                text: control.floatingLabelText
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 16 * A.dp
            }

            states: [
                State {
                    name: "FloatingLabelOnTop"
                    when: control.hasFloatingLabel && (control.activeFocus || control.text !=="")

                    PropertyChanges {
                        target: floatingLabelTextItem
                        font.pixelSize: 12 * A.dp
                        color: control.color;
                        anchors.bottomMargin: 40 * A.dp
                    }
                },
                State {
                    name: "HasFloatingLabel"
                    when: control.hasFloatingLabel

                    PropertyChanges {
                        target: style
                        placeholderTextColor : Constants.transparent
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    to: "FloatingLabelOnTop"
                    reversible: true

                    NumberAnimation {
                        target: floatingLabelTextItem
                        properties: "anchors.bottomMargin,font.pixelSize"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                    ColorAnimation {
                        targets: floatingLabelTextItem
                        properties: "color"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                    ColorAnimation {
                        targets: style
                        properties: "placeholderTextColor"
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            ]            
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

