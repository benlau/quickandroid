/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.0
import QuickAndroid 0.1
import "./Private"

/*!
   \qmltype Ink
   \inqmlmodule QuickAndrid 0.1
   \brief Ink Component
 */

MouseArea {
    id: ink
    clip: true

    /*!
      This property holds a value to indicate should it force ripple to be generated
      at the center of component in any case.

      The default value is false.
     */

    property bool centered: false

    /*!
      The MouseArea item to be listened to generate ripple effect.

      The default value is the Ink item.
      User may assign another MouseArea to be listened.
     */
    property var mouseArea: ink

    /*!
      \qmlproperty color color

      This property holds the color of ripple.
     */
    property color color: Constants.black12

    /*!
      \qmlproperty real maxRadius

      This property holds the max radius of ripple.
     */

    property alias maxRadius: surface.maxRadius

    /*! \qmlproperty real minRadius

      This property holds the min radius of ripple
     */

    property alias minRadius: surface.minRadius

    RippleSurface {
        id: surface;
        color: ink.color
        anchors.fill: parent
    }

    Connections {
        target: mouseArea
        onPressed: {
            var x = mouse.x;
            var y = mouse.y;

            if (centered) {
                x = surface.width / 2
                y = surface.height / 2
            }

            surface.tap(x,y);
        }

        onReleased: {
            surface.clear();
        }

        onCanceled: {
            surface.clear();
        }
    }
}

