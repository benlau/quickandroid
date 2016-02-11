/* Quick Android Project

   Author: Ben Lau
   License: Apache-2.0
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1
import QuickAndroid 0.1
import "./Styles"
import "./Private"
import "./drawable"

/*!
   \qmltype Dialog
   \inqmlmodule QuickAndrid 0.1
   \brief Dialog Component
 */

FocusScope {
    id: dialog

    signal rejected

    signal accepted

    property string title

    // The result code on done
    property int result;

    property string acceptButtonText;
    property string rejectButtonText

    property bool isOpened: false

    /*! This property hold an indicator to choose to show a dark background behind the dialog.

      The default value is true.
     */

    property bool darkBackground: true

    property alias acceptButton : acceptButton

    property alias rejectButton : rejectButton

    default property alias content: container.children

    property DialogMaterial material : ThemeManager.currentTheme.dialog

    property color tintColor: material.tintColor

    focus: isOpened;

    function open() {
        isOpened = true
    }

    function close() {
        isOpened = false;
    }

    function reject() {
        done(0); // QDialog::Rejected
    }

    function accept() {
        done(1); // QDialog::Accepted
    }

    function done(code) {
        result = code;
        if (code === 0) {
            rejected();
        } else {
            accepted();
        }
        close();
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back ||
            event.key === Qt.Key_Escape) {
            dialog.isOpened = false;
            event.accepted = true;
        }
    }

    Overlay {
        enabled: isOpened

        Mask {
            anchors.fill: parent
            active: isOpened && darkBackground
        }

        MouseArea {
            anchors.fill: parent
            enabled: isOpened
            onClicked: done(0);
        }

        Paper {
            id: paper
            anchors.centerIn: parent
            radius: 2 * A.dp

            property int minWidth : 280 * A.dp
            property int maxWidth: 380 * A.dp
            property int minHeight: 112 * A.dp

            property bool buttonVisible: acceptButtonText !== "" || rejectButtonText !== ""

            // The height of title section
            property int titleHeight: title === "" ? 24 * A.dp : titleItem.height + (24 + 20) * A.dp
            property int buttonHeight: !buttonVisible ?  24 * A.dp : (52+8+24) * A.dp
            width: {
                var w = paper.parent.width - 50 * A.dp;
                if (w > maxWidth)
                    w = maxWidth
                if (w < minWidth)
                    w = minWidth;
                if (w > paper.parent.width)
                    w = paper.parent.width;
                return w;
            }

            height: {
                var res = 0;
                if (title !== "") {
                    res += titleHeight;
                }

                if (buttonVisible) {
                    res += buttonHeight;
                }

                res += container.height

                if (res< minHeight)
                    res = minHeight;

                return res;
            }

            opacity: isOpened ? 1 : 0
            enabled: isOpened

            MouseArea {
                anchors.fill: parent
            }

            Text {
                id: titleItem
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 24 * A.dp
                anchors.rightMargin: 24 * A.dp
                anchors.topMargin: 24 * A.dp

                text: title
                type: Constants.largeText
                wrapMode: Text.WordWrap
            }

            Item {
                id: container
                objectName: "ContentSection"
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    leftMargin: 24 * A.dp
                    rightMargin: 24 * A.dp
                    topMargin: paper.titleHeight
                }

                height: childrenRect.height
            }

            Item {
                id: buttonSection
                objectName: "DialogButtonSection"
                width: parent.width
                height: visible ? 52 * A.dp : 0
                enabled: visible
                visible: paper.buttonVisible

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 8 * A.dp
                anchors.bottom: parent.bottom

                Button {
                    id: rejectButton
                    text: rejectButtonText
                    textColor: tintColor
                    enabled: rejectButtonText !== ""

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: acceptButtonText !== "" ? acceptButton.left : parent.right
                        rightMargin: 8 * A.dp
                    }
                    onClicked: {
                        done(0);
                    }
                }

                Button {
                    id: acceptButton
                    text: acceptButtonText
                    textColor: tintColor

                    enabled: acceptButtonText !== ""
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 8 * A.dp
                    }

                    onClicked: {
                        done(1);
                    }
                }

            }


            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

            }
        }
    }
}
