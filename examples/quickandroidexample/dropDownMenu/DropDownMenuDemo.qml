import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
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
            icon : A.drawable("ic_menu",Constants.black87)
            onClicked:  {
                dropDownMenu.open();
            }
        }
    }

    DropDownMenu {
        id: dropDownMenu
        anchorView: menuButton
        anchorPoint: Constants.rightTop
        model: VisualItemModel {
            ListItem { title: "Share"; showDivider: false }
            ListItem { title: "Copy" ; showDivider: false}
            ListItem { title: "Delete"; showDivider: false }
        }
    }

    Text {
        id: label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color : Constants.black87
        font.pixelSize: Style.theme.largeText.textSize * A.dp
    }

}
