import QtQuick 2.0
import "./item/"
import QuickAndroid 0.1

PopupArea {
    id : popupMenu

    width: dropDownList.implicitWidth
    height: dropDownList.implicitHeight
    enabled : false

    property alias model : dropDownList.model
    property alias delegate : dropDownList.delegate
    property alias style : dropDownList.style
    property alias _style : dropDownList.style

    signal itemSelected(int index,Item item,var model);

    function toggle() {
        if (fromActiveToNull.running || fromNulltoActive.running)
            return;
        active = !active;
    }

    function itemAt(index){
        return dropDownList.itemAt(index)
    }

    DropDownList {
        id : dropDownList
        opacity: 0
        anchors.fill: parent
        anchors.topMargin: _style.verticalOffset * A.dp
        onItemSelected: popupMenu.itemSelected(index,item,model);
    }

    AnimationLoader {
        id : enterAnimation
        transition: fromNulltoActive
        source : popupMenu.style.windowEnterAnimation
        target: dropDownList
    }

    AnimationLoader{
        id : exitAnimation
        transition: fromActiveToNull
        source : popupMenu.style.windowExitAnimation
        target: dropDownList
    }

    states: [
        State {
            name: "Active"
            when : popupMenu.active

            PropertyChanges {
                target: dropDownList
                opacity: 1.0
            }

            PropertyChanges {
                target: popupMenu
                enabled : true
            }
        }
    ]

    transitions: [Transition {
            id : fromNulltoActive
            from: ""
            to: "Active"
        },
        Transition {
            id : fromActiveToNull
            from: "Active"
            to: ""
        }
    ]


}
