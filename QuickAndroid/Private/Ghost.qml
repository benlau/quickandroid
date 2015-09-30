/*
  Ghost is a special component that will be placed over target component but using the current coordinate system

  Project: https://github.com/benlau/quickandroid
  Author : benlau

 */
import QtQuick 2.0

Item {
    id : ghost
    property var target
    property var rectangle: target && target.parent ? ghost.parent.mapFromItem(target.parent,
                                                 target.x,target.y,
                                                 target.width,target.height) : Qt.rect(0,0,0,0)
    x: rectangle.x;
    y: rectangle.y;
    width: rectangle.width;
    height: rectangle.height;
}
