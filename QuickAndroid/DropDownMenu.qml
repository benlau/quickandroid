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
        for (var i = 0 ; i < repeater.count ;i++) {
            var item = repeater.itemAt(i);
            if (item.implicitWidth + margin> max ) {
                max = item.implicitWidth + margin;
            }
        }
        _contentWidth = max;
    }

    ScrollView {
        id: scrollView
        width: _contentWidth

        flickableItem.flickableDirection : Flickable.VerticalFlick
        flickableItem.interactive: true

        Item {
            width: _contentWidth
            height: childrenRect.height + 16 * A.dp

            Column {
                width: _contentWidth
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

