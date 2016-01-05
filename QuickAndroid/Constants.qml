/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.0
pragma Singleton

/*!
   \qmltype Constants
   \inqmlmodule QuickAndrid
   \brief Constants table
 */

QtObject {
    property string black : "#000000"
    property string black100 : "#000000"
    property string black87 : "#de000000"
    property string black54 : "#8a000000"
    property string black12 : "#1a000000"

    property string white: "#ffffff"
    property string white100: "#ffffff"
    property string white87 : "#deffffff"
    property string white54 : "#8affffff"
    property string white38 : "#61ffffff"

    property string transparent : "#00000000"

    /* Size */
    property string small: "small"
    property string large: "large"

    /* Text Size */
    property string smallText: "small"
    property string normalText: "normal"
    property string mediumText: "medium"
    property string largeText: "large"

    /* Alignment/Gravity */
    property string left : "left"
    property string right : "right"
    property string top : "top"
    property string bottom : "bottom"
    property string center : "center"
    property string leftTop : "leftTop"
    property string rightTop : "rightTop"
    property string leftBottom : "leftBottom"
    property string rightBottom : "rightBottom"

    // The z value of popup layer

    property int zPopupLayer :      100000000
    property int zInverseMouseArea: 200000000
}

