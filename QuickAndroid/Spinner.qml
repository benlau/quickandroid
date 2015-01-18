import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Item {
    id : spinner

    property int currentIndex : -1
    property var currentItem;
    implicitWidth : button.implicitWidth
    height:  48 * A.dp

    property string mode : "Dropdown"

    property SpinnerStyle style: Style.theme.spinner
    property SpinnerItemStyle itemStyle : Style.theme.spinnerItem

    property alias delegate : dropDownList.delegate
    property alias model : dropDownList.model

    signal itemSelected(int index,Item item,var model);

    QuickButton {
        id : button
        background: spinner.style.background

        onClicked: {
            dropDownList.toggle();
        }

        height : 48 * A.dp
//        contentHeight : content.implicitHeight

        content: Text {
                id : content
                anchors.verticalCenter: parent.verticalCenter
                elide : Text.ElideLeft
                maximumLineCount : 1
                wrapMode: Text.WrapAnywhere
                textStyle: spinner.style.textStyle
        }
    }

    PopupMenu {
        id : dropDownList
        anchors.left: button.left
        anchors.top: button.bottom
        onItemSelected: {
            dropDownList.active = false;
            currentIndex = index;
            spinner.itemSelected(index,item,model);
        }
    }

    onCurrentIndexChanged: {
        if (currentIndex < 0 || currentIndex >= model.count) {
            content.text = "";
            return;
        }
        var item = model.get(currentIndex);
        currentItem = dropDownList.itemAt(currentIndex);
        content.text = item.title;
    }

    onModelChanged: {
        currentIndex = 0;
    }
}
