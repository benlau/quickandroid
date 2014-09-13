// A behaviour component to grow the implicited size of a drawable according to the content within fillArea
import QtQuick 2.0

Item {
    id : behaviour

    property var target : parent

    property real contentWidth : target.fillArea.childrenRect.width
    property real contentHeight : target.fillArea.childrenRect.height

    property real _fillAreaRightMargin : target.fillArea.rightMargin
    property real _fillAreaBottomMargin : target.fillArea.bottomMargin

//    property real drawableImplicitWidth : Math.max(target.implicitWidth , target.fillArea.x + behaviour.contentWidth + _fillAreaRightMargin);
//    property real drawableImplicitHeight: Math.max(target.implicitHeight,target.fillArea.y + behaviour.contentHeight +  _fillAreaBottomMargin);
    property real drawableImplicitWidth :  Math.max(target.itemImplicitWidth,target.fillArea.x + behaviour.contentWidth + _fillAreaRightMargin)
    property real drawableImplicitHeight:  Math.max(target.itemImplicitHeight,target.fillArea.y + behaviour.contentHeight +  _fillAreaBottomMargin)

    QueuedSignal {
        id: q1
        onTriggered: {
            target.implicitWidth = drawableImplicitWidth;
        }
    }

    QueuedSignal {
        id : q2
        onTriggered: target.implicitHeight = drawableImplicitHeight;
    }

    Connections {
        target: behaviour.target
        // For case like QuickButton , the icon
        // may be loaded before the background in asychrononous loading.
        // It will ensure the implicit size will be set by DrawableGrowBehaviour
        onImplicitWidthChanged: updateWidth();
        onImplicitHeightChanged: updateHeight();
    }

    function updateWidth() {
        // Sometimes QueueSignal.onWhenChanged is not triggered during
        // construction. This can ensure target.implicitWidth is
        // assigned.

        if (target.implicitWidth !== drawableImplicitWidth)
            q1.post();
    }

    function updateHeight() {
        if (target.implicitHeight !== drawableImplicitHeight)
            q2.post();
    }

    onDrawableImplicitWidthChanged: {
        updateWidth();
    }

    onDrawableImplicitHeightChanged: {
        updateHeight();
    }

}
