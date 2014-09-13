import QtQuick 2.0
import "./android.js" as A
import "./res.js" as Res

Item {
    id : spinner

    property int currentIndex : -1
    property var currentItem;
    implicitWidth : button.implicitWidth
    height:  48 * A.dp

    property string mode : "Dropdown"

    property var animationStyle : (Res.Style.Animation.DropDownDown)

    property alias delegate : dropDownList.delegate
    property alias model : dropDownList.model

    signal itemSelected(int index,Item item,var model);

    QuickButton {
        id : button
        background: Res.Style.Spinner.background

        onClicked: {
            dropDownList.toggle();
        }

        height : 48 * A.dp
//        contentHeight : content.implicitHeight

        content: Text {
                id : content
                anchors.verticalCenter: parent.verticalCenter
                color : Res.Style.Spinner.textStyle.textColor.color
                font.pixelSize: Res.Style.SpinnerItemStyle.TextAppearance.textSize * A.dp
                elide : Text.ElideLeft
                maximumLineCount : 1
                wrapMode: Text.WrapAnywhere
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
