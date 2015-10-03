import QtQuick 2.0

Item {

    property bool isAppeared: false;

    signal appear();
    signal disappear();

    onAppear: {
        isAppeared = true;
    }

    onDisappear: {
        isAppeared = false;
    }
}

