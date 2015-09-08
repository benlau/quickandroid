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
        duration : Style.theme.activityDefaultDuration;
    }

    PropertyAnimation {
        target : anim.target
        property : "scale"
        from : 1
        to : 0.9
        duration : Style.theme.activityShortDuration;
    }
}

