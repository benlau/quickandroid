import QtQuick 2.0
import QtQuick.Controls 1.3
import QuickAndroid 0.1

Popup {
    id: dropDownMenu

    property var model : ListModel { }

    onAboutToOpen: {
        var max = 56 * A.dp
        var margin = 16 * A.dp
        for (var i = 0 ; i < repeater.count ;i++) {
            var item = repeater.itemAt(i);
            if (item.implicitWidth + margin> max) {
                max = item.implicitWidth + margin;
            }
        }
        scrollView.width = max;
    }

    ScrollView {
        id: scrollView

        flickableItem.flickableDirection : Flickable.VerticalFlick
        flickableItem.interactive: true
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            width: scrollView.width
            height: childrenRect.height + 16 * A.dp

            Column {
                width: scrollView.width
                y: 8 * A.dp
                Repeater {
                    id: repeater
                    width: scrollView.width

                    model: dropDownMenu.model
                }
            }
        }
    }
}

