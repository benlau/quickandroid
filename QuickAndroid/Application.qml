// It is the top-level component of QuickAndroid. It provides page
// transition and application configuration

import QtQuick 2.0
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./Styles"
import "global.js" as Global

FocusScope {
    id : application
    width: 480
    height: 640

    focus : true

    property Theme theme

    property var iconSource
    property var current;
    property var history : new Array

    // It is emitted when start() is being called
    signal aboutToBeStarted(var page,var options)

    // It is emitted when a page is started
    signal started(Item page)

    function back() {
        if (history.length === 0) // It is already the top most level page
            return;

        var animOptions = {
            target : current
        }
        var animComponent = Qt.createComponent(ThemeManager.currentTheme.activity.activityExitAnimation);

        var anim = animComponent.createObject(null,animOptions);

        var prev = history.pop();
        prev.enabled = false;

        anim.onStopped.connect(function() {
            current.parent = null;
            // Destroy now, Otherwise Qt may crash.
            current.destroy();

            prev.enabled = true

            if (prev.hasOwnProperty("appear"))
                prev.appear();

            current = prev;
        });

        anim.start();
        Qt.inputMethod.hide();
    }

    function start(component,options) {
        var comp,
            next;

        if (typeof component === "string") {
            comp = Qt.createComponent(component);
        } else {
            comp = component;
        }

        if (comp.status === Component.Error) {
            console.warn("Error:",comp.errorString());
            return;
        } else if (comp.status === Component.Loading) {
            var url = comp.url;
            comp = Qt.createComponent(url);
        }

        next = comp.createObject(application);

        if (next === null) {
            console.warn("Failed to create : " + component);
            console.warn(comp.errorString());
        }

        aboutToBeStarted(next,options);

        for (var i in options) {
            next[i] = options[i];
        }

        if (next.hasOwnProperty("application")) {
            next.application = application;
        }

        if (next.hasOwnProperty("onBack")) {
            next.onBack.connect(function() {
                 application.back();
            })
        }

        if (application.current) {
            application.current.enabled = false;            
        }

        next.focus = true;
        next.x = Qt.binding(function() {
            return application.x;
        });
        next.y = Qt.binding(function() {
            return application.y;
        });
        next.width =Qt.binding(function() {
            return application.width;
        });
        next.height = Qt.binding(function() {
            return application.height;
        });
        next.enabled = false;

        var animOptions = {
            target : next
        }

        var animComponent = Qt.createComponent(ThemeManager.currentTheme.activity.activityEnterAnimation);

        var anim = animComponent.createObject(null,animOptions);
        anim.onStopped.connect(function() {

            if (current) {
                if (current.hasOwnProperty("disappear")) {
                    current.disappear();
                }

                if (current.noHistory) {
                    current.parent = null;
                    current.destroy();
                } else {
                    history.push(current);
                }
            }
            next.enabled = true;
            next.focus = true;

            current = next;
            if (current.hasOwnProperty("started")) {
                current.started();
            }

            if (current.hasOwnProperty("appear")) {
                current.appear();
            }

            application.started(current);
            anim.destroy();
        });
        anim.start();

        Qt.inputMethod.hide();

        return next;
    }

    Drawable {
        id : background;
        anchors.fill: parent
        source : "#000000";
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            if (history.length > 0 ) { // Not the top page
                back();
                event.accepted = true;
            }
        }
    }

    onThemeChanged: {
        if (theme !== null)
            ThemeManager.currentTheme = theme;
    }

    Component.onCompleted: {
        Global.application = application
    }

    Component.onDestruction: {
        if (Global.application === application)
            Global.application = null;
    }

}
