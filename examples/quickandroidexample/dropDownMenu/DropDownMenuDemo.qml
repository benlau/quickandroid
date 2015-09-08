import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1
import "../theme"

Activity {

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("DropDownMenu Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

        menuBar : QuickButton {
            id: menuButton
            icon : "image://drawable/ic_menu.png?tintColor=" + escape(Constants.black87)
            onClicked:  {
                dropDownMenu.open();
                console.log(dropDownMenu.paper.width,dropDownMenu.paper.height);
            }
        }
    }

    DropDownMenu {
        id: dropDownMenu
        anchorView: menuButton
        anchorPoint: Constants.rightTop
        model: VisualItemModel {
            ListItem { title: "Share" }
            ListItem { title: "Copy" }
            ListItem { title: "Delete" }
        }
    }

    Text {
        id: label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color : Style.theme.black87
        font.pixelSize: Style.theme.largeText.textSize * A.dp
    }

}
