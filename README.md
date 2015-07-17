Quick Android - QML Theme and Component Library for Android
===========================================================
[![Build Status](https://travis-ci.org/benlau/quickandroid.svg?branch=master)](https://travis-ci.org/benlau/quickandroid)

Features
--------

 1. Provide “DP” unit
 2. Page transition management
  1. "Back" to previous page by the hardware back button
 3. Unified “Drawable” component
  1. A single component that supports color , image , QML component, simulated nine patch image as input source
  2. Auto scale image to fit current screen resolution
  3. Derived StateListDrawable for animated drawable like button
 4. Image provider that will find the right image for current resolution automatically.
 5. Theme / Style Engine
 6. A set of components with native look and feel on Android
 7. SystemDispatcher - C++ and Java communication manager. 
  1. Auto conversion between C++ and Java data type. No need to write in JNI.

UI Components

    ActionBar , Activity , Application , Drawable , StateListDrawable
    MaterialShadow , PopupMenu , Spinner , QuickButton , 
    Switch

Utility Components

    Dialog , DrawableGrowBehaviour, InverseMouseArea ,  PopupArea
    QueuedSignal , RectToRectMatrix , AnimationLoader ,
    Overlay , Ghost

Under Development Components

    SwipeViewer , NavigationDrawer

Instruction of use
------------------

 1) Clone this repository and bundle the folder within your source tree.

(It is recommended to use `git submodule` to embed this repository)

 2) Add this line to your profile file(.pro):

    include(quickandroid/quickandroid.pri) # You should modify the path by yourself

 3) Modify your main.cpp


```

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include "quickandroid.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;

    /* QuickAndroid Initialization */

    view.engine()->addImportPath("qrc:///"); // Add QuickAndroid into the import path
    QuickAndroid::registerTypes(); // It must be called before loaded any scene

    /* End of QuickAndroid Initialization */

    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:///splash.qml")));
    view.show();

    return app.exec();
}


```

 4) Import the package within your QML file by :

    import QuickAndroid 0.1

Notes of using DP
-----------------

You may get the DP/density value from the global variable "A.dp" after you have called the `QuickAndroid::registerTypes()` in your code. However, Qt Creator don't know the value and threfore the UI will be broken. In make it works , you have to declare a dummy data in your project. Check the example code: [dummydata/A.qml](tests/quickandroidexample/dummydata/A.qml)

Demonstration
-------------

An example program is available in the folder of [tests/quickandroidexample](tests/quickandroidexample) . You may build it by yourself or download the daily build from [drone.io](https://drone.io/github.com/benlau/quickandroid/files) .

Remarks: Daily build for non-master branch may not be working. 

![Screenshot](https://raw.githubusercontent.com/benlau/quickandroid/master/tests/quickandroidexample/docs/screenshot.png)

License
-------

The license of this project has been changed to Apache License 2.0

FAQ
---

Q. Looking for component that is not supported yet?

Please feel free to submit the request to the wiki. Moreover, you may take a look on other component library:

1. [Iktwo/components](https://github.com/Iktwo/components)
2. [rschiang/material](https://github.com/rschiang/material)

Q. Looking for iOS Native Component?

1. [hilarycheng/quickios](https://github.com/hilarycheng/quickios) (Still Under Development)

Q. Any library for ...?

1. Sharing
 1. [bdentino/Qtino.SharingKit](https://github.com/bdentino/Qtino.SharingKit)
