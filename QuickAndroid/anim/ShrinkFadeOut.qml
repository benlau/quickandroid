import QtQuick 2.0
import "../Styles"

ParallelAnimation {
    id : anim
    property var target

    PropertyAnimation{
        target : anim.target
        property : "opacity"
        from : 1
        to : 0
        duration : ThemeManager.currentTheme.activityDefaultDuration;
    }

    PropertyAnimation {
        target : anim.target
        property : "scale"
        from : 1
        to : 0.9
        duration : ThemeManager.currentTheme.activityShortDuration;
    }
}

