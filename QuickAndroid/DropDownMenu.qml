import QtQuick 2.0
import QtQuick.Controls 1.2
import QuickAndroid 0.1

Popup {
    id: dropDownMenu

    property var model : ListModel { }

    ScrollView {
        id: scrollView
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        flickableItem.flickableDirection : Flickable.VerticalFlick
        flickableItem.interactive: true

        Item {
            width: scrollView.width
            height: childrenRect.height + 16 * A.dp

            Column {
                width: scrollView.width
                y: 8 * A.dp
                Repeater {
                    id: listView
                    width: scrollView.width

                    model: dropDownMenu.model
                }
            }
        }
    }
}

