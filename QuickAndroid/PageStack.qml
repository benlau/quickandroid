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

    property bool asynchronous: true;

    function push(source, properties, animated) {
        var res  = priv._create(source, properties);

        if (running) {
            priv._enqueue({op: "push",
                      page: res.object,
                      incubator: res.incubator,
                      animated: animated}
                     );
        } else {
            running = true;
            priv._prePush(res.object, animated, res.incubator);
        }

        return res.object;
    }

    function pop(animated) {
        if (running) {
            priv._enqueue({op: "pop",
                      animated: animated});
        } else {
            running = true;
            priv._realPop();
        }
    }

    Item {
        id: priv;

        // Keep a reference to the incubator object after dequeue. (Ref: QTBUG-35587)
        property var _currentIncubator;

        property var _queue : new Array

        // Enqueue an task to be executed when previous tasks are finished.
        function _enqueue(task) {
            _queue.push(task);
        }

        // Dequeue and process the returned task. If no any task leave, set "running" to false
        function _processNext() {

            if (_queue.length === 0) {
                running = false;
                return;
            }

            var task = _queue.shift();

            if (task.op === "push") {
                _prePush(task.page, task.animated, task.incubator);
            } else {
                _realPop(task.animated);
            }
        }

        // Before real push, verify the page object. If it is an incubate object, wait until it is loaded.
        function _prePush(page, animated, isIncubator) {
            if (!isIncubator) {
                _realPush(page, animated);
            } else {
                if (page.status === Component.Loading) {

                    // QTBUG-35587: Keep a reference to the incubator to avoid GC.
                    _currentIncubator = page;

                    page.onStatusChanged = function(status) {
                        _prePushIncubator(page, animated);
                    };

                } else {
                    _prePushIncubator(page, animated);
                }
            }
        }

        function _prePushIncubator(incubator, animated) {
            switch (incubator.status) {
            case Component.Error:
                console.warn("PageStack: Failed to create push object");
                _processNext();
                break;
            case Component.Ready:
                _realPush(incubator.object, animated);
                break;
            default:
                console.warn("Unexcepted error");
                break;
            }
        }

        function _realPush(page, animated) {
            animated = animated === undefined ? true : animated;

            try {
                running = true;
                page.stack = pageStack;
                page.parent = pageStack;

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
            var incubator = asynchronous && (typeof (source)  === "string" || String(source).indexOf("QQmlComponent") === 0);
            var object = Utils.createObject(source, pageStack, properties, asynchronous);

            return {
                object: object,
                incubator: incubator
            }
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

