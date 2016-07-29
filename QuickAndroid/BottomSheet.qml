/* BottomSheet Component

   Author: Ben Lau
   License: Apache-2.0
   Project: https://github.com/benlau/quickandroid

 */

import QtQuick 2.0
/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick.Controls 1.2
import QuickAndroid 0.1
import "./drawable"


/*!
   \qmltype BottomSheet
   \inqmlmodule QuickAndroid 0.1
   \brief Bottom Sheet Component
 */


Item {
    id: bottomSheet

    /*!
      \qmlproperty bool isOpened

      This property indicatr is the bottom sheet opened.
     */

    property bool isOpened: false

    /*! \qmlproperty Item content

        The internal item that contains the Items to be shown in BottomSheet.
     */

    default property alias content : dragArea.children

    /*! \qmlproperty Paper paper

       This property hold the background paper of BottomSheet

       User may modify the style by manipulate this property
     */

    property alias paper: paper


    /*! \qmlperoperty bool darkBackground

    This property indicate will BottomSheet create a dark mask on the background while opened.
     */

    property bool darkBackground: true

    /*! \qmlmethod void open()

      Open the bottom sheet
     */

    function open() {
        isOpened = true;
    }

    /*! \qmlmethod void close()

      Close the bottom sheet
     */

    function close() {
        isOpened = false;
    }

    clip: true
    anchors.fill: parent
    z: Constants.zPopupLayer

    Mask {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: paper.top

        MouseArea {
            anchors.fill: parent
            onPressed: close();
        }
        active: darkBackground && isOpened
        enabled: isOpened
    }

    Paper {
        id: paper
        width: bottomSheet.width
        height: dragArea.height
        y: bottomSheet.height
        property int targetY: bottomSheet.height - paper.height

        function __onDragged() {
            if (paper.y !== bottomSheet.height - paper.height) {
                close();
            }
        }

        MouseArea {
            // Dirty hack for a bug in Qt
            // p.s You can't reproduce on desktop. Use Android.
            anchors.fill: parent

            drag.axis: Drag.YAxis
            drag.target: paper
            drag.minimumY: paper.targetY

            drag.onActiveChanged: {
                if (!drag.active) {
                    paper.__onDragged();
                }
            }
        }

        MouseArea {
            id: dragArea
            width: bottomSheet.width
            height: childrenRect.height

            drag.axis: Drag.YAxis
            drag.target: paper
            drag.filterChildren: true
            drag.minimumY: paper.targetY

            drag.onActiveChanged: {
                if (!drag.active) {
                    paper.__onDragged();
                }
            }
        }
    }

    states : [
        State {
            when: isOpened

            PropertyChanges {
                target: paper

                y: bottomSheet.height - paper.height
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"

            NumberAnimation {
                target: paper
                properties: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    ]
}

