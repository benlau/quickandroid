import QtQuick 2.0
import QuickAndroid.def 0.1

/** Application Theme Component (based on Material Design)

  Author : benlau

  Reference: http://developer.android.com/training/material/theme.html
 */

QtObject {
    id : theme

    property var colorPrimary : "#BBDEFB" // blue 100
    property var colorPrimaryDark : "#1565C0" // blue 800
    property var textColorPrimary : "#de000000"
    property var windowBackground: "#EFEFEF"
    property var navigationBarColor : "#FFFFFF"

    property TextStyle middleText : TextStyle {
        textSize: 14
        textColor : Color.black87
    }

    property ActionBarStyle actionBar : ActionBarStyle {
        background : theme.colorPrimary
        actionButtonBackground : Qt.resolvedUrl("../drawable/ItemBackgroundHoloLight.qml")
        titleTextStyle: middleText
        homeAsUpIndicator : Qt.resolvedUrl("../drawable-xxhdpi/ic_ab_back_holo_light_am.png")
        homeMarginLeft: -2
        divider : Color.black12
        padding: 8
    }

}
