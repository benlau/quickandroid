import QtQuick 2.0
import "../Styles"

ParallelAnimation {
    id : anim
    property var target

    PropertyAnimation{
        target : anim.target
        property : "opacity"
        from : 0
        to : 1
        duration : ThemeManager.currentTheme.activityDefaultDuration;
    }

    PropertyAnimation {
        target : anim.target
        property : "scale"
        from : 0.9
        to : 1
        duration : ThemeManager.currentTheme.activityShortDuration;
    }

}
