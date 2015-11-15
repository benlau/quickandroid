import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QuickAndroid 0.1
import QuickAndroid.Private 0.1

TextFieldStyle {

    padding.top: 16 * A.dp
    padding.bottom: 16 * A.dp
    padding.left: 0
    padding.right: 0

    textColor: control.enabled ? control.textColor : Qt.lighter(control.textColor,150);

    placeholderTextColor: control.placeholderTextColor

    background: Item {

    }

    property Component __selectionHandle: Image {
        source:  "image://quickandroid-drawable/text_select_handle_left"
        asynchronous: true
        x: -width / 4 * 3
        y: styleData.lineHeight
    }

    property Component __cursorHandle: Image {
        source: styleData.hasSelection ? "image://quickandroid-drawable/text_select_handle_right"
                  : "image://quickandroid-drawable/text_select_handle_middle"
        asynchronous: true
        x: styleData.hasSelection ? -width / 4 : -width / 2
        y: styleData.lineHeight
    }

}

