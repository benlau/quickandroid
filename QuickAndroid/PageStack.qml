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
        var page;

        try {
            animated = animated === undefined ? true : animated;

            page = Utils.createObject(source,pageStack,properties);
            page.stack = pageStack;

            if (topPage && topPage.noHistory) {
                var originalTopPage = topPage;
                if (pages.length >= 2) {
                    topPage = pages[pages.length - 2];
                } else {
                    topPage = null;
                }
                pages.pop();
                pagesChanged();

                originalTopPage.disappear();
                popped(topPage);
                originalTopPage.parent = null;
                originalTopPage.destroy();
            }

            // Event flow
            // 1) Update topPage
            // 2) pagesChanged
            // 3) pushed/popped
            // 4) aboutToPresent/aboutToDismiss

            var bottomPage = topPage;
            topPage = page;
            pages.push(page);
            pagesChanged();
            pushed(page);

            page.aboutToPresent();

            if (!bottomPage)
                bottomPage = dummyPage;

            var transitionComp = page.transitionAnimation;

            var transition = transitionComp.createObject(page,
                                                         {
                                                             container: pageStack,
                                                             upperView: page,
                                                             lowerView: bottomPage
                                                         });
            page._transition = transition;

            function finished() {
                transition.presentTransitionFinished();
                bottomPage.disappear();
                page.appear();
                page.presented();
                page.focus = true;
                page.enabled = true;
            }

            transition.presentTransitionStarted();

            if (animated) {
                transition.presentTransition.onStopped.connect(finished);
                transition.presentTransition.start();
            } else {
                finished();
            }

        } catch (e) {
            console.error(e);
            console.trace();
        }

        return page;
    }

    function pop(animated) {
        try {
            if (pages.length === 1) {
                return;
            }

            animated = animated === undefined ? true : animated;
            var transition = topPage._transition;
            var poppedPage = pages.pop();

            topPage = pages[pages.length - 1];
            pagesChanged();
            popped(poppedPage);

            poppedPage.aboutToDismiss();

            function finished() {
                transition.dismissTransitionFinished();
                poppedPage.disappear();
                poppedPage.dismissed();
                poppedPage.parent = null;
                poppedPage.destroy();
                topPage.appear();
                topPage.focus = true;
            }

            transition.dismissTransitionStarted();

            if (animated) {
                transition.dismissTransition.onStopped.connect(finished);
                transition.dismissTransition.start();
            } else {
                finished();
            }

        } catch(e) {
            console.error(e);
            console.trace();
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

