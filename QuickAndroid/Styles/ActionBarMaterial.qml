/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Web: https://github.com/benlau/quickandroid
*/

import QtQuick 2.0
import QuickAndroid 0.1

/*!
   \qmltype ActionBarMaterial
   \inqmlmodule QuickAndrid.Styles 0.1
   \brief Parameter for ActionBar Material Design Style
 */

Material {
    id: material
    property var iconSource : ""

    property size iconSourceSize : Qt.size(24 * A.dp,24 * A.dp)

    property color backgroundColor

    property Component background : Rectangle {
        color: control.backgroundColor
    }

    property Component actionButtonBackground: Rectangle {
        color: control.pressed ? "#1A000000" : Constants.transparent
    }

    property TextMaterial title : TextMaterial {}
    property var homeAsUpIndicator

    property var divider : "#1A000000"
    property var padding : 8 * A.dp

    property int keyline1: 16 * A.dp

    property int keyline2: 72 * A.dp

    /// The expected height if icon, title. It is also the implicit height of Action Bar.
    property int unitHeight: 56 * A.dp

}
