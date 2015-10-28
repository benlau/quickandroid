import QtQuick 2.0
import "./utils.js" as Utils
import "./Transitions"

Item {
    id: pageStack

    property var initialPage : null

    property var currentPage : null

    property var history: new Array

    function push(source,properties,animated) {
        animated = animated === undefined ? true : animated;

        var page = Utils.createObject(source,pageStack,properties);
        history.push(page);

        var bottomPage = currentPage;
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
            currentPage = page;
        }

        if (animated) {
            transition.presentTransition.onStopped.connect(finished);
            transition.presentTransition.start();
        } else {
            finished();
        }
    }

    function pop(animated) {
        if (history.length === 1) {
            return;
        }

        animated = animated === undefined ? true : animated;
        var transition = currentPage._transition;
        history.pop();
        var prevPage = history[history.length - 1];

        function finished() {
            transition.dismissTransitionFinished();
            prevPage.appear();
            currentPage.disappear();
            currentPage.destroy();
            currentPage = prevPage;
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

