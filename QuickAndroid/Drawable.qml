// Drawable resource(image/qml) loader
import QtQuick 2.0
import "./android.js" as A

Rectangle {
    id : drawable

    property bool pressed

    property var source
    property var status

    // The container/parent of "item". It must be the direct child of drawable
    // Sometime it will be same as "item"
    property var canvas

    // Dynamic created content by the source.
    property var item;

    // The resolution of source
    property real dp : 1

    property alias content : fillAreaItem.children

    property alias fillArea : fillAreaItem

    property bool asynchronous: false

    // The scaled implicit size of the dynamic created item.
    property int itemImplicitWidth : 0
    property int itemImplicitHeight: 0

    function _dpOfSource(source) {
        var dpiTable = ["ldpi","mdpi","hdpi","xhdpi","xxhdpi","xxxhdpi"];
        var dpTable = [ 0.75,1,1.5,2,3,4];
        var dp = 1;
        for (var i = dpiTable.length -1 ;i >=0;i--) {
            if (source.indexOf(dpiTable[i]) !== -1) {
                dp = dpTable[i];
                break;
            }
        }
        return dp
    }

    Component {
        id : loaderBuilder
        Loader {
            id : loader
            z: -1
            source : drawable.source
            anchors.fill: parent
            asynchronous: drawable.asynchronous
            onStatusChanged: {
                drawable.status = loader.status;

                if (status == Loader.Error) {
                    console.warn("Failed to load ",source);
                }
            }

            onLoaded: {
                if (loader.item.ninePatch) {
                    // It is a fake ninepatch component simulated by BorderImage
                    // It can't resize due to the limitation of BorderImage.
                    // It will be scaled manually

                    var ratio = A.dp / loader.item.dp
                    var container = ninePatchContainer.createObject(drawable);

                    container.zoom = ratio

                    loader.parent = container.content
                    loader.anchors.fill = container.content
                    loader.transformOrigin = Item.TopLeft
                    loader.scale = ratio;
                    canvas = container

                    drawable.implicitWidth = item.implicitWidth * ratio;

                    drawable.implicitHeight = item.implicitHeight * ratio;
                    drawable.itemImplicitWidth = drawable.implicitWidth;
                    drawable.itemImplicitHeight = drawable.implicitHeight;

                    if (item.fillArea) {
                        fillArea.target = item.fillArea
                        fillArea.zoom = ratio;
                    }

                } else { // QML component but not nine patch
                    canvas = loader

                    loader.parent = drawable
                    loader.anchors.fill = drawable
                    drawable.implicitWidth = item.implicitWidth;

                    drawable.implicitHeight = item.implicitHeight;
                    drawable.itemImplicitWidth = drawable.implicitWidth;
                    drawable.itemImplicitHeight = drawable.implicitHeight;

                    if (item.fillArea) {
                        fillArea.target = item.fillArea
                    }
                }

                drawable.item = item;
            }
        }
    }

    Component{
        id : imageBuilder
        Image {
            id : item
            z: -1
            source : drawable.source
            anchors.fill: parent
            asynchronous: drawable.asynchronous
            property bool resized : false

            onStatusChanged: {
                drawable.status = item.status;
            }

            onSourceSizeChanged: {
                if (resized)
                    return;
                dp = _dpOfSource(String(source));
                var w = sourceSize.width * A.dp / dp;
                var h = sourceSize.height * A.dp / dp;

                resized = true;
                sourceSize = Qt.size(w,h);

                // The implicitWidth will be set once only.
                // As component like DrawableGrowBehaviour
                // will also update the implicit size
                drawable.implicitWidth = w
                drawable.implicitHeight = h                
                drawable.itemImplicitWidth = drawable.implicitWidth;
                drawable.itemImplicitHeight = drawable.implicitHeight;
            }

            Component.onCompleted: {
                canvas = item
                drawable.item = item
            }
        }
    }

    Component {
        id : ninePatchContainer
        Item {
            id : container
            z: -1
            property real zoom : 1
            property alias content : contentItem
            anchors.fill: parent
            Item {
                id : contentItem
                width : container.width / zoom
                height : container.height / zoom
            }
        }
    }

    // If the source is an item, it will be the container of the item.
    Component {
        id: sourceItemContainer
        Item {
            id: container
            property var content
            anchors.fill: parent
            z: -1

            onContentChanged: {
                content.parent = container
                content.anchors.fill = container
                drawable.implicitWidth = content.implicitWidth
                drawable.implicitHeight = content.implicitHeight
                drawable.itemImplicitWidth = drawable.implicitWidth;
                drawable.itemImplicitHeight = drawable.implicitHeight;

                if (content.fillArea) {
                    drawable.fillArea.target = content.fillArea
                    drawable.fillArea.zoom = 1
                } else {
                    drawable.fillArea.target = container
                }

                drawable.canvas = container
                drawable.item = content
            }
        }
    }

    // The fill area of this drawable component
    Item {
        id : fillAreaItem

        // The position and size of fillAreaItem will be equal to target which is not its parent/child
        property var target : drawable

        // Scale fillAreaItem based on the size of target
        property real zoom : 1

        property int rightMargin : target && target.rightMargin !==undefined ? target.rightMargin * zoom  : 0
        property int bottomMargin : target && target.bottomMargin !==undefined ? target.bottomMargin * zoom : 0

        x : target ? target.x * zoom : 0
        y : target ? target.y * zoom : 0
        width : target ? target.width * zoom : 0
        height : target ? target.height * zoom : 0
    }

    onSourceChanged: {
        if (!source)
            return;

        if (canvas) {
            canvas.destroy();
            canvas = null;
        }

        fillArea.target = drawable
        fillArea.zoom = 1

        drawable.color = "#00000000"

        if (typeof source === "object") {
            sourceItemContainer.createObject(drawable,{ content : source })
        } else {
            var qml = source.search(/\.qml$/i);
            if (qml !== -1) {
                loaderBuilder.createObject(drawable);
            } else if ( /(^#[0-9A-F]{8}$)|(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(source) ) {
                // Color code
                drawable.color = source;
            } else {
                // Image source
                imageBuilder.createObject(drawable);
            }
        }
    }
}
