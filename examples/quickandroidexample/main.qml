import QtQuick 2.2
import QtQuick.Window 2.2
import QuickAndroid 0.1
import QuickAndroid.Styles 0.1
import "./theme"

Window {
    id: window;
    width: 480
    height: 640

    color: "#FFFFFF"

    visible: false;

    /* Fast Splash Screen Setup Instruction

      1. Create a custom theme (apptheme.qml) and set windowBackground to @drawable/splash.xml (Your splash screen drawable)

      2. Within AndroidManifest.xml, set android.app.splash_screen_drawable to @drawable/splash.xml

        <!-- Splash screen -->
            <meta-data android:name="android.app.splash_screen_drawable" android:resource="@drawable/splash"/>
        <!-- Splash screen -->

      That will show a splash screen while Qt is loading. However, screen flicker will happen when your Window
      item is shown. To prevent screen flicker completely, you could setup your main.qml accoroding to step 3.

      3. In your main.qml (the one with Window component)

      3.1. Set Window.color to a color which is similar to splash screen / Theme.windowBackground

      3.2. Set visible of Window to false until your content is loaded. (Keep Android splash screen while loading)

      3.3. Use an asynchronous Loader for your content. Set opacity to 0.

      3.4. Once everything is ready, set Window.visible to true and perform a fade-in animation on Loader

     */

    Loader {
        id: loader
        parent: null
        width: window.width
        height: window.height
        asynchronous: true
        opacity: 0
        focus: true;

        sourceComponent: PageStack {
            id: stack
            objectName: "PageStack";
            initialPage: Components {

                onPresented: {
                    window.visible = true;
                    A.setTimeout(function() {
                        loader.parent = window.contentItem;
                        loader.opacity = 1;
                    }, 34);
                }
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad;
            }
        }
    }

    Component.onCompleted: {
        ThemeManager.currentTheme = AppTheme
    }
}
