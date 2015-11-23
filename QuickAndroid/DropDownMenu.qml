import QtQuick 2.4
import QtQuick.Controls 1.2
import QuickAndroid 0.1
import "./Styles"

Popup {
    id: dropDownMenu

    property var model : ListModel { }

    property DropDownMenuMaterial material: ThemeManager.currentTheme.dropDownMenu

    property int _contentWidth: 56 * A.dp

    onAboutToOpen: {
        var multipler = 56 * A.dp;
        var max = 0;
        var h = 0;
        for (var i = 0 ; i < repeater.count ;i++) {
            var item = repeater.itemAt(i);
            if (item.implicitWidth> max ) {
                max = item.implicitWidth;
            }
            h += item.height
        }

        var w = Math.ceil(max / multipler) * multipler;

        scrollView.implicitWidth = w;
        scrollView.implicitHeight = h + (material.topPadding  + material.bottomPadding); // + top and bottom padding
    }

    ScrollView {
        id: scrollView

        flickableItem.flickableDirection : Flickable.VerticalFlick
        flickableItem.interactive: true
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Item {
            width: scrollView.width
            height: childrenRect.height + (material.topPadding + material.bottomPadding)

            Column {
                width: scrollView.width
                y: material.topPadding
                Repeater {
                    id: repeater
                    width: scrollView.width

                    model: dropDownMenu.model
                }
            }
        }
    }
}

