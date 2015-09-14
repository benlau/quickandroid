// Drawable resource(image/qml) loader
import QtQuick 2.0
import QuickAndroid 0.1

Rectangle {
    id : drawable

    property bool pressed

    /// Drawable supports multiple type of source. It support "image","hex code of color","qml", Item, Component
    property var source

    /// The status of loading resource
    property var status

    // The container/parent of "item". It must be the direct child of drawable
    // Sometime it will be same as "item"
    property var canvas

    // Dynamic created content by the source.
    property var item: null;

    // Set this property to define what happens when the source image has a different size than the item.
    property int fillMode : Image.Stretch

    // The resolution of source
    property real dp : 1

    // The "content" region of drawable
    property alias content : fillAreaItem.children

    property alias fillArea : fillAreaItem

    property bool asynchronous: false

    // The scaled implicit size of the dynamic created item.
    property int itemImplicitWidth : 0
    property int itemImplicitHeight: 0

    /// Return TRUE if the input is a color object
    function isColor(value) {
        return  /(^#[0-9A-F]{8}$)|(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(String(source).toUpperCase());
    }

    function _dpOfSource(source) {
        var dpiTable = ["ldpi","mdpi","hdpi","xhdpi","xxhdpi","xxxhdpi"];
        var dpTable = [ 0.75,1,1.5,2,3,4];
        var dp = A.dp;
        for (var i = dpiTable.length -1 ;i >=0;i--) {
            if (source.indexOf(dpiTable[i]) !== -1) {
                dp = dpTable[i];
                break;
            }
        }
        return dp
    }

    function _createObject(source) {
        drawable.item = source.createObject(drawable);
        drawable.canvas = drawable.item;
        drawable.item.anchors.fill = drawable;
    }

    Component {
        id : loaderBuilder
        Loader {
            id : loader
            // Never bind the "source" property to "drawable.source'. Whatever you have changed the source, it will be loaded twice.
            z: -1            
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
                    } else {
                        fillArea.target = drawable
                        fillArea.zoom = 1;
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
                    } else {
                        fillArea.target = drawable
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
            anchors.fill: parent
            asynchronous: drawable.asynchronous
            fillMode: drawable.fillMode
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

        // Reset fillArea.target here may generate a lot of loop detected warning message
//        fillArea.target = drawable
        fillArea.zoom = 1;

        drawable.color = Constants.transparent;

        if (isColor(source)) {
            // color can be an object or string
            drawable.color = source;
        } else if (typeof source === "object") {

            if (String(source).indexOf("QQmlComponent") === 0) {
                _createObject(source);
            } else {
                sourceItemContainer.createObject(drawable,{ content : source })
            }
        } else {
            var qml = source.search(/\.qml$/i);
            if (qml !== -1) {
                loaderBuilder.createObject(drawable,{source: drawable.source});
            } else {
                // Image source
                imageBuilder.createObject(drawable,{source: drawable.source});
            }
        }
    }
}
