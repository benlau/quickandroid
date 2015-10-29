import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "../theme"

Page {

    actionBar: ActionBar {
        id: actionBar
        upEnabled: true
        title: qsTr("DropDownMenu Demo")
        showTitle: true

        onActionButtonClicked: back();
        z: 10

        menuBar : Button {
            id: menuButton
            iconSource : A.drawable("ic_menu",Constants.black87)
            iconSourceSize: Qt.size(A.px(24),A.px(24));
            onClicked:  {
                dropDownMenu.open();
            }
        }
    }

    DropDownMenu {
        id: dropDownMenu
        anchorView: menuButton
        anchorPoint: Constants.rightTop
        model: VisualDataModel {
            model: ListModel {
                ListElement { title: "Share" }
                ListElement { title: "Copy" }
                ListElement { title: "Delete"}
            }

            delegate: ListItem {
                title: model.title
                showDivider: false
                onClicked: {
                    dropDownMenu.close();
                    label.text = model.title;
                }
            }

        }
    }

    Text {
        id: label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color : Constants.black87
        font.pixelSize: ThemeManager.currentTheme.largeText.textSize
    }

}
