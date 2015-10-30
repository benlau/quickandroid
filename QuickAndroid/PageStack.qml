/* Page Component
   Author: Ben Lau
   License: Apache-2.0
   Website: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import "./utils.js" as Utils
import "./Transitions"

FocusScope {
    id: pageStack

    property var initialPage : null

    property var topPage : null

    readonly property int count: pages.length

    readonly property var pages : new Array

    signal pushed(Item page)

    signal popped(Item page)


    focus: true

    function push(source,properties,animated) {
        animated = animated === undefined ? true : animated;

        var page = Utils.createObject(source,pageStack,properties);
        page.stack = pageStack;

        if (topPage && topPage.noHistory) {
            var originalTopPage = topPage;
            if (pages.length >= 2) {
                topPage = pages[pages.length - 2];
            } else {
                topPage = null;
            }
            pages[pages.length - 1] = page;
            pagesChanged();

            originalTopPage.disappear();
            popped(topPage);
            originalTopPage.destroy();
            pushed(page);
        } else {
            pages.push(page);
            pagesChanged();
            pushed(page);
        }

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
            bottomPage.disappear();
            page.appear();
            page.presented();
            page.focus = true;
            page.enabled = true;
            topPage = page;
        }

        transition.presentTransitionStarted();

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
        var poppedPage = pages.pop();
        pagesChanged();
        popped(poppedPage);

        var prevPage = pages[pages.length - 1];

        function finished() {
            transition.dismissTransitionFinished();
            topPage.disappear();
            topPage.dismissed();
            topPage.destroy();
            prevPage.appear();
            prevPage.focus = true;
            topPage = prevPage;
        }

        transition.dismissTransitionStarted();

        if (animated) {
            transition.dismissTransition.onStopped.connect(finished);
            transition.dismissTransition.start();
        } else {
            finished();
        }
    }

    Page {
        id: dummyPage
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back &&
            pages.length > 1) {
            event.accepted = true;
            pop();
        }
    }

    Component.onCompleted: {
        if (initialPage !== null) {
            push(initialPage,{},false);
        }
    }
}

