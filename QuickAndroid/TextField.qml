import QtQuick 2.0
import QtQuick.Controls 1.2 as Control
import QtQuick.Controls.Styles 1.3 as ControlSyles
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Control.TextField {
    height: 48 * A.dp

    property TextFieldStyle aStyle: ThemeManager.currentTheme.textField

    property color colorAccent: aStyle.colorAccent

    style: ControlSyles.TextFieldStyle {
        padding.top: 16 * A.dp
        padding.bottom: 16 * A.dp
        padding.left: 0
        padding.right: 0

        font {
            pixelSize: aStyle.textStyle.textSize
        }

        background: Item {

            Rectangle {
                height: control.activeFocus ? 2 * A.dp : 1 * A.dp
                color: control.colorAccent
                width: parent.width
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

