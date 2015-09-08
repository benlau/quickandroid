import QtQuick 2.0
import QtQuick.Controls 1.2
import QuickAndroid 0.1

Popup {
    id: dropDownMenu

    property var model : ListModel { }

    property int _contentWidth: 56 * A.dp

    onAboutToOpen: {
        var max = 56 * A.dp
        var margin = 16 * A.dp
        var h = 0;
        for (var i = 0 ; i < repeater.count ;i++) {
            var item = repeater.itemAt(i);
            if (item.implicitWidth + margin> max ) {
                max = item.implicitWidth + margin;
            }
            h+=item.height
        }
        scrollView.implicitWidth = max;
        scrollView.implicitHeight = h;
    }

    ScrollView {
        id: scrollView

        flickableItem.flickableDirection : Flickable.VerticalFlick
        flickableItem.interactive: true

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

