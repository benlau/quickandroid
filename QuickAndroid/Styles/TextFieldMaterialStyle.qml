import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QuickAndroid 0.1
import QuickAndroid.Private 0.1

TextFieldPlainStyle {

    id: style

    objectName: "TextFieldStyleInstance"
    padding.top: (control.hasFloatingLabel ? 40 * A.dp : 16 * A.dp) + control._fontDiff - 2
    padding.bottom: 16 * A.dp
    padding.left: 0
    padding.right: 0

    textColor:  control.enabled ? control.textColor : control.material.text.disabledTextColor

    TextMetrics {
        id: textMetrics
        font: control.font
        text: "012345678"
    }

    background: Item {
        id: bg
        objectName: "Background"

        property int floatingLabelBottomMarginOnTop : 16 * A.dp + textMetrics.height + 8 * A.dp

        Rectangle {
            id: inactiveUnderline
            height: 1 * A.dp
            color: control.material.inactiveColor
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
            color: control.material.disabledColor
            penStyle: Line.DotLine
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8 * A.dp
        }

        Text {
            id: floatingLabelTextItem
            objectName: "FloatingLabelText"
            font.pixelSize: control.floatingLabelAlwaysOnTop ? 12 * A.dp : control.material.text.textSize
            color: control.material.text.disabledTextColor
            text: control.floatingLabelText
            anchors.bottom: parent.bottom
            anchors.bottomMargin: control.floatingLabelAlwaysOnTop ?  bg.floatingLabelBottomMarginOnTop : 16 * A.dp
        }

        states: [
            State {
                name: "FloatingLabelOnTop"
                when: control.hasFloatingLabel && (control.activeFocus || control.text !=="")

                PropertyChanges {
                    target: floatingLabelTextItem
                    font.pixelSize: 12 * A.dp
                    color: control.color;
                    anchors.bottomMargin: bg.floatingLabelBottomMarginOnTop
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
}

