import QtQuick 2.0

QtObject {

    /// The container provide the geometry information
    property Item container : null;

    /// The view going to be presented or dismissed.
    property Item upperView : Item {}

    /// The original view.
    property Item lowerView : Item {}

    signal appear

    signal disappear

    function presentTransitionStarted() {
        upperView.x = Qt.binding(function() { return container ? container.x  : 0});
        upperView.y = Qt.binding(function() { return container ? container.y : 0});
        upperView.width = Qt.binding(function() { return container ? container.width : 0 });
        upperView.height = Qt.binding(function() { return container ? container.height : 0});
        upperView.anchors.centerIn = upperView.parent
    }

    function presentTransitionFinished() {
        lowerView.enabled = false;
        upperView.enabled = true;
    }

    function dismissTransitionStarted() {
    }

    function dismissTransitionFinished() {
        upperView.visible = false;
        upperView.enabled = false;
        lowerView.enabled = true;
    }

    property var presentTransition: ParallelAnimation {

        PropertyAnimation{
            target : upperView
            property : "opacity"
            from : 0
            to : 1
            duration : 100
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target : upperView
            property : "scale"
            from : 0.8
            to : 1
            duration : 100
            easing.type: Easing.OutQuad
        }

    }

    property var dismissTransition: ParallelAnimation {
        PropertyAnimation{
            target : upperView
            property : "opacity"
            from : 1
            to : 0
            duration : 100
            easing.type: Easing.InQuad
        }

        PropertyAnimation {
            target : upperView
            property : "scale"
            from : 1
            to : 0.8
            duration : 100
            easing.type: Easing.InQuad
        }
    }


}

