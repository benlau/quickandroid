/*
   SwipeView - Paged Scrolling View Component

   License: Apache License
   Author : @benlau
   Project: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0

ListView {
    clip: true
    orientation: ListView.Horizontal
    snapMode: ListView.SnapOneItem

    highlightRangeMode: ListView.StrictlyEnforceRange
    highlightMoveDuration: 460
}

