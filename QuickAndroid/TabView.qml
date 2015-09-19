import QtQuick 2.0

SwipeView {
    id: view

    property TabBar tabBar

    Connections {
        target: view.tabBar
        ignoreUnknownSignals: true
        onCurrentIndexChanged: {
            if (view.currentIndex !== tabBar.currentIndex)
                view.currentIndex = tabBar.currentIndex;
        }
    }

    onCurrentIndexChanged: {
        if (!tabBar)
            return;
        if (tabBar.currentIndex !== view.currentIndex)
            tabBar.currentIndex = view.currentIndex;
    }
}

