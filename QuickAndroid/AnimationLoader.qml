import QtQuick 2.0

Item {
    id : loader
    property var target

    property var source : null

    property var anim;

    property var transition;

    onSourceChanged: {
        if (!source)
            return;

        var component = Qt.createComponent(source);
        anim = component.createObject(null,{ target : Qt.binding(function(){
            return loader.target;
        }) });

        transition.animations = [anim];
    }
}
