import QtQuick 2.2
import QtQuick.Window 2.1
import QuickAndroid 0.1
import QuickAndroid.style 0.1

Activity {

    actionBar: ActionBar {
        id : actionBar
        title: "Quick Android Example Program"
        z: 10
        actionButtonEnabled: false

        MaterialShadow {
            asynchronous: true
            anchors.fill: actionBar
            depth: 1
            z: -1
        }
    }

    ListModel {
        id: listModel
        ListElement {
            name : "Spinner"
            preview : "spinner/SpinnerPreview.qml"
            demo: "spinner/SpinnerDemo.qml"
        }

        ListElement {
            name : "Shadow"
            preview : "shadow/ShadowPreview.qml"
            demo: "shadow/ShadowDemo.qml"
        }

        ListElement {
            name : "Popup Menu"
            preview : "popupmenu/PopupMenuPreview.qml"
            demo: "popupmenu/PopupMenuDemo.qml"
        }

        ListElement {
            name : "Dialog"
            preview : "dialog/DialogPreview.qml"
            demo: "dialog/DialogDemo.qml"
        }

        ListElement {
            name : "Text Input"
            preview : "textinput/TextInputPreview.qml"
            demo: "textinput/TextInputDemo.qml"
        }

        ListElement {
            name : "Switch"
            preview : "switch/SwitchPreview.qml"
            demo : "switch/SwitchDemo.qml"
        }

    }

    ListView {
        anchors.fill: parent

        model : listModel
        delegate : QuickButton {
            height: 72 * A.dp
            width: parent.width

            Rectangle {
                id : preview
                anchors.left: parent.left
                anchors.leftMargin: 16 * A.dp
                anchors.verticalCenter: parent.verticalCenter
                width: 48 * A.dp
                height: 48 * A.dp
                border.color: "#1A000000"
                color : "#999999"

                Loader {
                    id : loader
                    x: 1 * A.dp
                    y: 1 * A.dp
                    asynchronous: true
                    visible: false
                    source: Qt.resolvedUrl(model.preview)
                    onLoaded: visible = true

                    transform: RectToRectMatrix {
                        source: Qt.rect(0,0,loader.width + 8 * A.dp,loader.height +8 *A.dp)
                        dest: Qt.rect(0,0,preview.width - x * 2,preview.height - x * 2)
                    }
                }
            }


            Text {
                id: title
                text: model.name
                anchors.left: preview.right
                anchors.leftMargin: 16 * A.dp
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Style.theme.mediumText.textSize * A.dp
                color : Style.theme.black87
            }

            Rectangle {
                id: divider
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1 * A.dp
                color : "#1A000000"
            }

            onClicked: {
                start(Qt.resolvedUrl(model.demo));
            }
        }
    }

}
