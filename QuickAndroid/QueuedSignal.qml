import QtQuick 2.0

Item {
    id : queuedSignal

    property var when

    signal triggered

    // Post to emit the signal
    function post(){
        if (timer.running)
            return
        timer.start();
    }

    Timer {
        id : timer
        interval : 1
        onTriggered: {
            queuedSignal.triggered();
        }
    }

    onWhenChanged: {
        post();
    }
}

