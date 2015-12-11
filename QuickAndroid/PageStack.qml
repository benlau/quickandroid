/* Quick Android Project
   Author: Ben Lau
   License: Apache-2.0
   Website: https://github.com/benlau/quickandroid
 */

import QtQuick 2.0
import "./utils.js" as Utils
import "./Transitions"

/*!
   \qmltype PageStack
   \inqmlmodule QuickAndrid 0.1
   \brief PageStack Component
 */

FocusScope {
    id: pageStack

    property var initialPage : null

    property var topPage : null

    readonly property int count: pages.length

    readonly property var pages : new Array

    /*!
      It is true if the page is either of pushing or poping.
     */

    property bool running: false

    signal pushed(Item page)

    signal popped(Item page)

    focus: true

    property var _queue : new Array

    function push(source,properties,animated) {
        var page = _create(source, properties);

        if (running) {
            _enqueue({op: "push",
                      page: page,
                      animated: animated});
        } else {
            _realPush(page, animated);
        }

        return page;
    }

    function pop(animated) {
        if (running) {
            _enqueue({op: "pop",
                      animated: animated});
        } else {
            _realPop();
        }
    }

    function _enqueue(task) {
        _queue.push(task);
    }

    function _processNext() {

        if (_queue.length === 0) {
            running = false;
            return;
        }

        var task = _queue.shift();

        if (task.op === "push") {
            _realPush(task.page, task.animated);
        } else {
            _realPop(task.animated);
        }
    }

    function _realPush(page, animated) {
        animated = animated === undefined ? true : animated;

        try {
            running = true;
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
                popped(originalTopPage);
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
                _processNext();
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
            _processNext();
        }
    }

    function _realPop(animated) {
        animated = animated === undefined ? true : animated;
        running = true;

        try {
            if (pages.length === 1) {
                _processNext();
                return;
            }

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
                _processNext();
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
            _processNext();
        }
    }

    function _create(source, properties) {
        // @TODO - support asynchronous
        return Utils.createObject(source, pageStack, properties);
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

