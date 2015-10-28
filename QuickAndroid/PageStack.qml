import QtQuick 2.0
import "./utils.js" as Utils
import "./Transitions"

Item {
    id: pageStack

    property var initialPage : null

    property var topPage : null

    readonly property int count: pages.length

    readonly property var pages : new Array

    function push(source,properties,animated) {
        animated = animated === undefined ? true : animated;

        var page = Utils.createObject(source,pageStack,properties);
        page.stack = pageStack;

        if (topPage && topPage.noHistory) {
            topPage.disappear();
            topPage.destroy();
            if (pages.length >= 2) {
                topPage = pages[pages.length - 2];
            } else {
                topPage = null;
            }
            pages[pages.length - 1] = page;
        } else {
            pages.push(page);
        }
        pagesChanged();

        var bottomPage = topPage;
        if (!bottomPage)
            bottomPage = dummyPage;

        var transitionComp = page.transition;

        var transition = transitionComp.createObject(page,
                                                     {
                                                         container: pageStack,
                                                         topView: page,
                                                         bottomView: bottomPage
                                                     });
        page._transition = transition;

        function finished() {
            transition.presentTransitionFinished();
            page.appear();
            bottomPage.disappear();
            topPage = page;
        }

        if (animated) {
            transition.presentTransition.onStopped.connect(finished);
            transition.presentTransition.start();
        } else {
            finished();
        }

        return page;
    }

    function pop(animated) {
        if (pages.length === 1) {
            return;
        }

        animated = animated === undefined ? true : animated;
        var transition = topPage._transition;
        pages.pop();
        pagesChanged();

        var prevPage = pages[pages.length - 1];

        function finished() {
            transition.dismissTransitionFinished();
            prevPage.appear();
            topPage.disappear();
            topPage.destroy();
            topPage = prevPage;
        }

        if (animated) {
            transition.dismissTransition.onStopped.connect(finished);
            transition.dismissTransition.start();
        } else {
            finished();
        }
    }

    function back() {
        pop();
    }

    Page {
        id: dummyPage
    }

    Component.onCompleted: {
        if (initialPage !== null) {
            push(initialPage,{},false);
        }
    }
}

