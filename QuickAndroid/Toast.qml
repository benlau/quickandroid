import QtQuick 2.0
import QuickAndroid 0.1

Item {
    /// The message that will be displayed when show() is called
    property string text: ''

    /// If set to true, the toast duration will be long
    property bool longDuration: false

    readonly property string m_TOAST_MESSAGE: "quickandroid.Toast.showToast"

    /// Displays the Toast with the current set text and duration
    function show() {
        SystemDispatcher.dispatch(m_TOAST_MESSAGE, {
                                      text: text,
                                      longLength: longDuration
                                  });
    }

    Component.onCompleted: {
        SystemDispatcher.loadClass("quickandroid.Toast");
    }
}

