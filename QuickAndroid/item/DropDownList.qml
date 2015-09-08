// A drop down list item component. It is not proposed to use lonely.

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1

Item {
    id : dropDownList
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    signal itemSelected(int index,Item item,var model);

    property var model
    property int currentIndex : -1
    property var currentItem;

    property DropDownStyle style : Style.theme.dropdown

    property Component delegate : QuickButton {
        id : button
        implicitHeight: hidden ? 0 : 48 * A.dp
        property bool hidden : model.hidden === undefined ? false : model.hidden
        visible : !hidden

        text: model.title
        style.background : dropDownList.style.button
        style.textStyle: dropDownList.style.textStyle
        gravity: "left"

        Loader {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            sourceComponent: dropDownList.style.divider
        }

    }

    function itemAt(index){
        return repeater.itemAt(index)
    }

    Drawable {
        id : background
        source: style.background

        content : Column {
            id : column
            spacing : 0
            Repeater {
                id : repeater
                model : dropDownList.model

                delegate: Item {
                    id : container
                    width: loader.width
                    height: loader.height
                    property var _model : model
                    property var _index : index
                    Loader {
                        id : loader
                        property var model : _model
                        property var index : _index
                        sourceComponent : dropDownList.delegate
                        height: item.implicitHeight
                        width: repeater.width

                        function updateWidth() {
                            if (item.implicitWidth > repeater.width) {
                                repeater.width = item.implicitWidth;
                            }
                        }

                        onLoaded: {
                            updateWidth();
                        }

                        Connections {
                            target : loader.item

                            ignoreUnknownSignals: true

                            onClicked: {
                                mouse.accepted = false;
                                currentIndex = index;
                                itemSelected(index,loader.item,model);
                            }

                            onImplicitWidthChanged: loader.updateWidth();
                        }
                    }
                }
            }
        }

        DrawableGrowBehaviour {}
    }
}
