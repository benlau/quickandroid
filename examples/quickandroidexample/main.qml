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

    /* Tips to prevent screen flicker from splash screen to your application

      1. Set Window.color to a color which is similar to splash screen / Theme.windowBackground
      2. Set visible of Window to false until your content is loaded
      3. Use an asynchronous Loader for your content. Set opacity to 0.
      4. Once everything is ready, set Window.visible to true and perform a fade-in animation on Loader
     */

    // Prevent screen flicker
    Loader {
        id: loader
        anchors.fill: parent
        asynchronous: true
        opacity: 0
        focus: true;

        sourceComponent: PageStack {
            id: stack
            objectName: "PageStack";
            initialPage: Components {

                onPresented: {
                    window.visible = true;
                    loader.opacity = 1;
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
