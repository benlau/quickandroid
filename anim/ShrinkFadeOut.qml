import QtQuick 2.0
import "../res.js" as Res

ParallelAnimation {
    id : anim
    property var target

    PropertyAnimation{
        target : anim.target
        property : "opacity"
        from : 1
        to : 0
        duration : Res.config.config_activityDefaultDur;
    }

    PropertyAnimation {
        target : anim.target
        property : "scale"
        from : 1
        to : 0.9
        duration : Res.config.config_activityShortDur;
    }
}

