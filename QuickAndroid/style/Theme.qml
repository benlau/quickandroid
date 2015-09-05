import QtQuick 2.0
import QuickAndroid 0.1

/** Application Theme Component (based on Material Design)

  Author : benlau

  Reference: http://developer.android.com/training/material/theme.html
 */

QtObject {
    id : theme

    property color colorPrimary : "#BBDEFB" // blue 100
    property color colorPrimaryDark : "#1565C0" // blue 800
    property color textColorPrimary : Constants.black87
    property color windowBackground: "#EFEFEF"
    property color navigationBarColor : "#FFFFFF"

    property int activityDefaultDuration: 220
    property int activityShortDuration: 150

    // colors_material.xml
    property string black : "#000000"
    property string black87 : "#de000000"
    property string black54 : "#8a000000"

    property string white : "#ffffff"
    property string white87 : "#deffffff"
    property string white38 : "#61ffffff"

    // Metric
    property int keyline1: 16
    property int keyline2: 72

    // Normal test style
    property TextStyle text : TextStyle {
        textSize: 16
        textColor: textColorPrimary
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

    property ActivityStyle activity : ActivityStyle {
        activityEnterAnimation : Qt.resolvedUrl("../anim/ActivityEnter.qml")
        activityExitAnimation : Qt.resolvedUrl("../anim/ActivityExit.qml")
        background: Qt.resolvedUrl("../drawable/BackgroundHoloLight.qml")
    }

    property ButtonStyle button: ButtonStyle {
    }

    property ActionBarStyle actionBar : ActionBarStyle {
        background : "#E6E6E6"
        actionButtonBackground : Qt.resolvedUrl("../drawable/ItemBackgroundHoloLight.qml")
        titleTextStyle: mediumText
        homeAsUpIndicator : Qt.resolvedUrl("../drawable-xxhdpi/ic_ab_back_holo_light_am.png")
        homeMarginLeft: -2
        divider : Constants.black12
        padding: 8
        keyline1: theme.keyline1
        keyline2: theme.keyline2
    }

    property SpinnerStyle spinner : SpinnerStyle {
        background : Qt.resolvedUrl("../drawable/SpinnerAbHoloLight.qml")
        popupBackground : Qt.resolvedUrl("../drawable/SpinnerDropdownBackground.qml")
        dropDownSelector : Qt.resolvedUrl("../drawable/ListSelectorHoloLight.qml")
        dropDownVerticalOffset : -10
        textStyle : TextStyle {
            textSize :  actionBar.titleTextStyle.textSize
            textColor :  actionBar.titleTextStyle.textColor
        }
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

    property DialogStyle dialog : DialogStyle {
        windowEnterAnimation : Qt.resolvedUrl("../anim/GrowFadeIn.qml")
        windowExitAnimation: Qt.resolvedUrl("../anim/ShrinkFadeOut.qml")
    }

    property ListItemStyle listItem : ListItemStyle {
        leftPadding: keyline1
        rightPadding: keyline1
        titleKeyline: keyline2
    }

    // Allow to place children under Theme.
    default property alias children: theme.__children
    property list<QtObject> __children: [QtObject {}]
}
