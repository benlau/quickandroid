import QtQuick 2.4
import QtQuick.Controls 1.2
import QuickAndroid 0.1
import "./Styles"

Popup {
    id: dropDownMenu

    property var model : ListModel { }

    property DropDownMenuStyle style: Style.theme.dropDownMenu

    property int _contentWidth: 56 * A.dp

    onAboutToOpen: {
        var multipler = 56 * A.dp;
        var max = 0;
        var margin = 16 * A.dp
        var h = 0;
        for (var i = 0 ; i < repeater.count ;i++) {
            var item = repeater.itemAt(i);
            if (item.implicitWidth + margin> max ) {
                max = item.implicitWidth + margin;
            }
            h += item.height
        }

        var w = Math.ceil(max / multipler) * multipler;

        scrollView.implicitWidth = w;
        scrollView.implicitHeight = h + (style.topPadding  + style.bottomPadding) * A.dp; // + top and bottom padding
    }

    ScrollView {
        id: scrollView

        flickableItem.flickableDirection : Flickable.VerticalFlick
        flickableItem.interactive: true
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            width: scrollView.width
            height: childrenRect.height + (style.topPadding + style.bottomPadding) * A.dp

            Column {
                width: scrollView.width
                y: style.topPadding * A.dp
                Repeater {
                    id: repeater
                    width: scrollView.width

                    model: dropDownMenu.model
                }
            }
        }
    }
}

