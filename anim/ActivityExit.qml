import QtQuick 2.0

ParallelAnimation {
    id : anim
    property var target

    PropertyAnimation{
        target : anim.target
        property : "opacity"
        from : 1
        to : 0
        duration : 100
    }

    PropertyAnimation {
        target : anim.target
        property : "scale"
        from : 1
        to : 0.8
        duration : 100
    }

}
