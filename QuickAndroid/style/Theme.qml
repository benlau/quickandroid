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
    property var textColorPrimary : Color.black87
    property var windowBackground: "#EFEFEF"
    property var navigationBarColor : "#FFFFFF"

    // Normal test style
    property TextStyle text : TextStyle {
        textSize: 16
        textColor : textColorPrimary
    }

    property TextStyle smallText : TextStyle {
        textSize: 14
        textColor : textColorPrimary
    }

    property TextStyle mediumText : TextStyle {
        textSize: 18
        textColor : textColorPrimary
    }

    property TextStyle largeText : TextStyle {
        textSize: 22
        textColor : textColorPrimary
    }

    property ActivityStyle activityStyle : ActivityStyle {
        activityEnterAnimation : Qt.resolvedUrl("../anim/ActivityEnter.qml")
        activityExitAnimation : Qt.resolvedUrl("../anim/ActivityExit.qml")
        background: Qt.resolvedUrl("../drawable/BackgroundHoloLight.qml")
    }

    property ButtonStyle button: ButtonStyle {
        background : Qt.resolvedUrl("../drawable/BtnDefault.qml")
        textStyle : mediumText
    }

    property ActionBarStyle actionBar : ActionBarStyle {
        background : theme.colorPrimary
        actionButtonBackground : Qt.resolvedUrl("../drawable/ItemBackgroundHoloLight.qml")
        titleTextStyle: mediumText
        homeAsUpIndicator : Qt.resolvedUrl("../drawable-xxhdpi/ic_ab_back_holo_light_am.png")
        homeMarginLeft: -2
        divider : Color.black12
        padding: 8
    }

    property SpinnerStyle spinner : SpinnerStyle {
        background : Qt.resolvedUrl("../drawable/SpinnerAbHoloLight.qml")
        popupBackground : Qt.resolvedUrl("../drawable/SpinnerDropdownBackground.qml")
        dropDownSelector : Qt.resolvedUrl("../drawable/ListSelectorHoloLight.qml")
        dropDownVerticalOffset : -10
        textStyle : actionBar.titleTextStyle
        divider : Qt.resolvedUrl("../drawable/DividerHorizontalHoloLight.qml");
    }

    property SpinnerItemStyle spinnerItem : SpinnerItemStyle {
        textStyle: mediumText
        paddingStart: 8
        paddingEnd: 8
    }

    property DropDownStyle dropdown : DropDownStyle {
        background : Qt.resolvedUrl("../drawable/MenuDropdownPanelHoloLight.qml")
        verticalOffset: -10
        textStyle: actionBar.titleTextStyle
        divider: Qt.resolvedUrl("../drawable/DividerHorizontalHoloLight.qml")

        // Custom Style
        button : Qt.resolvedUrl("../drawable/BtnDropdown.qml");

        windowEnterAnimation : Qt.resolvedUrl("../anim/GrowFadeIn.qml")
        windowExitAnimation: Qt.resolvedUrl("../anim/ShrinkFadeOut.qml")
    }

    property TextInputStyle textInput : TextInputStyle {
        background : "#00000000"
        textStyle : mediumText
        textSelectHandle : Qt.resolvedUrl("../drawable-xxhdpi/text_select_handle_middle.png")
    }

    property SwitchStyle switchStyle : SwitchStyle {
        track: Qt.resolvedUrl("../drawable/SwitchBgHoloLight.qml")
        thumb: Qt.resolvedUrl("../drawable/SwitchThumbHoloLight.qml")
        textStyle: smallText
        thumbTextPadding: 12
        switchMinWidth: 96
        switchPadding: 16
    }

    property DialogStyle dialogStyle : DialogStyle {
        windowEnterAnimation : Qt.resolvedUrl("../anim/GrowFadeIn.qml")
        windowExitAnimation: Qt.resolvedUrl("../anim/ShrinkFadeOut.qml")
    }

}
