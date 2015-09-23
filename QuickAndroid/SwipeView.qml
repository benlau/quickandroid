/*
   SwipeView - Paged Scrolling View Component

   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import QuickAndroid 0.1

ListView {
    id: swipeView
    clip: true
    orientation: ListView.Horizontal
    snapMode: ListView.SnapOneItem

    highlightRangeMode: ListView.StrictlyEnforceRange
    highlightMoveDuration: 460

    QtObject {
        id: controller
        property int prevIndex: -1
        property Item prevItem;
        property bool poking : false
        function poke() {
            if (poking)
                return;
            poking = true;
            A.setTimeout(function() {
                run();
            },0);
        }

        function emit() {
            if (prevItem && prevItem.hasOwnProperty("disappear")) {
                prevItem.disappear();
            }

            if (currentItem.hasOwnProperty("appear")) {
                currentItem.appear();
            }
        }

        function run() {
            poking = false;

            if (prevIndex !== currentIndex &&
                !dragging &&
                !moving &&
                contentX === swipeView.width * currentIndex ) {
                controller.emit();
                prevIndex = currentIndex;
                prevItem = currentItem;
            }
        }
    }

    onCurrentIndexChanged: controller.poke();
    onContentXChanged: controller.poke();
}

