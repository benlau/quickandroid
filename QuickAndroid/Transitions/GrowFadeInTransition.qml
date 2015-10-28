import QtQuick 2.0

QtObject {

    /// The container provide the geometry information
    property Item container : null;

    /// The view going to be presented or dismissed.
    property Item topView : Item {}

    /// The original view.
    property Item bottomView : Item {}

    signal appear

    signal disappear

    function presentTransitionFinished() {

        topView.x = Qt.binding(function() { return container ? container.x  : 0});
        topView.y = Qt.binding(function() { return container ? container.y : 0});
        topView.width = Qt.binding(function() { return container ? container.width : 0 });
        topView.height = Qt.binding(function() { return container ? container.height : 0});
        bottomView.enabled = false;
        topView.enabled = true;

    }

    function dismissTransitionFinished() {
        topView.visible = false;
        topView.enabled = false;
        bottomView.enabled = true;
    }

    property var presentTransition: ParallelAnimation {

        PropertyAnimation{
            target : topView
            property : "opacity"
            from : 0
            to : 1
            duration : 100
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target : topView
            property : "scale"
            from : 0.8
            to : 1
            duration : 100
            easing.type: Easing.OutQuad
        }

    }

    property var dismissTransition: ParallelAnimation {
        PropertyAnimation{
            target : topView
            property : "opacity"
            from : 1
            to : 0
            duration : 100
            easing.type: Easing.InQuad
        }

        PropertyAnimation {
            target : topView
            property : "scale"
            from : 1
            to : 0.8
            duration : 100
            easing.type: Easing.InQuad
        }
    }


}

