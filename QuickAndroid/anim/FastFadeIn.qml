import QtQuick 2.0

// Reference: fast_fade_in.xml

PropertyAnimation {
    property : "opacity"
    from : 0.0
    to : 1.0
    duration: 80
    easing.type: Easing.OutQuad
}
