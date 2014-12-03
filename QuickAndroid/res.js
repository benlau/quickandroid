// Default resource and management functions

.pragma library

// A deep copy function
function extend() {
    var args = Array.prototype.slice.call(arguments, 0);
    var target = args[0];
    var objects = args.slice(1,args.length);

    for (var i in objects) {
        var next = objects[i];
        for (var j in next) {
            if (typeof next[j] === "object") {
                if (target[j] === undefined)
                    target[j] = {};
                extend(target[j],next[j])
            } else {
                target[j] = next[j];
            }

        }
    }

    return target;
}

// Deep copy of attributes that is existed on dst only.
function copy(dst,src) {
    for (var i in dst) {
        if (src.hasOwnProperty(i)) {
            if (typeof src[i] === "object") {
                if (typeof dst[i] !== "object")
                    dst[i] = {}
                dst[i] = extend(dst[i],src[i]);
            } else {
                dst[i] = src[i];
            }
        }
    }

    return dst;
}

/* Style */

// values/styles.xml
var Style = {};

function load(style) {
    extend(Style,style);
}

// Default Theme is Holo Light

var colors = {
    bright_foreground_light :"#ff000000",
    bright_foreground_dark : "#ffffffff",

    bright_foreground_disabled_holo_light : "#ffb2b2b2",
    background_dark : "#ff000000",
    background_holo_light : "#fff3f3f3",

    bright_foreground_disabled_holo_light: "#ffb2b2b2",
    bright_foreground_holo_light : "#fff3f3f3",

    bright_foreground_light_disabled: "#80000000",

    dim_foreground_disabled_holo_light: "#80323232",
    dim_foreground_holo_light:"#323232"
}

var config = {
    config_activityDefaultDur : 220,
    config_activityShortDur : 150
}

Style.Theme = {
    colorBackground : "drawable/BackgroundHoloLight.qml"
}

Style.TextAppearance = {
    textSize : 16,
    textColor : {
        // primary_text_light.xml
        disabled : colors.bright_foreground_light_disabled,
        focused :  colors.bright_foreground_light,
        pressed:   colors.bright_foreground_light,
        activated: colors.bright_foreground_light,
        color:     colors.bright_foreground_light
    }
};

Style.TextAppearance.Large = extend({},Style.TextAppearance,{
    textSize : 22
});

Style.TextAppearance.Medium = extend({},Style.TextAppearance,{
    textSize : 18
});

Style.TextAppearance.Small = extend({},Style.TextAppearance,{
    textSize: 14,
    textColor : {
        disabled : colors.dim_foreground_disabled_holo_light,
        focused :  colors.dim_foreground_holo_light,
        pressed:   colors.dim_foreground_holo_light,
        activated: colors.dim_foreground_holo_light,
        color:     colors.dim_foreground_holo_light
    }
});

Style.dividerVertical = "#1A000000"

/* ActionBar */


/*
Style.ActionBar = {
    icon : "",
    background : "drawable/ActionBarBackground.qml",
    actionButtonBackground : "drawable/ItemBackgroundHoloLight.qml",
    titleTextStyle : extend({},Style.TextAppearance.Medium),
    homeAsUpIndicator : "drawable-xxhdpi/ic_ab_back_holo_light_am.png",
    homeMarginLeft: -2,
    divider: Style.dividerVertical,
    padding : 8
}

Style.Widget = {
}


Style.Widget.Button = {
    background : "drawable/BtnDefault.qml",
    textAppearance : extend({},Style.TextAppearance.Medium)
}

// Widget.Spinner.DropDown
Style.Widget.DropDown = {
    background : "drawable/MenuDropdownPanelHoloLight.qml",
//    dropDownSelector: "drawable/ListSelectorHoloLight.qml",
    verticalOffset: -10,
    textStyle : extend({},Style.ActionBar.titleTextStyle),
    divider: "drawable/DividerHorizontalHoloLight.qml",

    // Custom Style
    button : "drawable/BtnDropdown.qml"
}

Style.Widget.TextInput = {
    background : "#00000000",
    textStyle : extend({},Style.TextAppearance.Medium),
    textSelectHandle : Qt.resolvedUrl("drawable-xxhdpi/text_select_handle_middle.png")
}

Style.Widget.CompoundButton = {};

Style.Widget.CompoundButton.Switch = {
    track: Qt.resolvedUrl("drawable/SwitchBgHoloLight.qml"),
    thumb: Qt.resolvedUrl("drawable/SwitchThumbHoloLight.qml"),
    switchTextAppearance: extend({},Style.TextAppearance.Small,{
                                     textColor : {
                                         color : "#ffffff"
                                     }
                                 }),
    thumbTextPadding: 12,
    switchMinWidth: 96,
    switchPadding: 16
}
*/

Style.Animation = {}

Style.Animation.Activity = {
    activityEnterAnimation : "anim/ActivityEnter.qml",
    activityExitAnimation : "anim/ActivityExit.qml"
}

Style.Animation.DropDownDown = {
    windowEnterAnimation : "anim/GrowFadeIn.qml",
    windowExitAnimation: "anim/ShrinkFadeOut.qml"
}

Style.Animation.Dialog = {
    windowEnterAnimation : "anim/GrowFadeIn.qml",
    windowExitAnimation: "anim/ShrinkFadeOut.qml"
}

Style.Animation.TextInput = {
    textSelectHandleEnter : Qt.resolvedUrl("./anim/FastFadeIn.qml"),
    textSelectHandleExit : Qt.resolvedUrl("./anim/FastFadeOut.qml")
}

/* Material Design */

// colors_material.xml
Style.Black87 = "#de000000"
Style.Black54 = "#8a000000"
Style.White87 = "#deffffff"
Style.White38 = "#61ffffff"

