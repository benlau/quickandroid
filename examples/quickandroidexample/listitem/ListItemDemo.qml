import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

/*
  Lists: Controls - Components - Google design guidelines
  https://www.google.com/design/spec/components/lists-controls.html
 */

Page {
    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("List Item Demo")
        showTitle: true

        onActionButtonClicked: back();
    }

    Column {
        anchors.fill: parent

        ListItem {
            iconSource: "image://drawable/ic_android_black_48dp?tintColor=" + escape(ThemeManager.currentTheme.black54)
            title: "Icon , Right Icon , Title and Subtitle"
            subtitle: "Subtitle"
            rightIcon: Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "image://drawable/ic_done_black_24dp?tintColor=" + escape(ThemeManager.currentTheme.black54)
            }
        }

        ListItem {
            title: "Title only"
        }

        ListItem {
            title: "Title + value text"
            value: "Value"
        }

        ListItem {
            title: "Title + value text (56dp height)"
            value: "Value"
            height: 56 * A.dp
        }

    }

}
