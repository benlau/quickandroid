Quick Android - QML Theme and Component Library for Android
===========================================================

Features
--------

 1. Provides “DP” unit
 2. Page transition management
 3. Multiple type “Drawable” component
  1. A single component that supports color , image , QML component , simulated nine patch image as input source
  2. Auto scale image to fit current screen resolution
  3. Derived StateListDrawable for animated drawable like button
 4. Theme / Style Engine
 5. Animation Management

UI Components

    ActionBar , Activity , Application , Drawable , StateListDrawable
    MaterialShadow , PopupMenu , Spinner , QuickButton

Utility Components

    Dialog , DrawableGrowBehaviour, InverseMouseArea ,  PopupArea
    QueuedSignal , RectToRectMatrix , AnimationLoader

Under Development Components

    SwipeViewer , NavigationDrawer

Instruction of use
------------------

*1. Using QML Component*

a. Clone this repository and bundle the folder within your source tree.

(It is recommended to use `git subdmoule` to embed this repository)

b. Add this line to your profile file(.pro):

    include(quickandroid/quickandroid.pri) # You should modify the path by yourself
    
c. Import the package within your QML file by :

    import QuickAndroid 0.1

d. Setup the import path in your main.cpp:

    engine->addImportPath("qrc:///"); // engine is an instance of QQmlEngine for your project. Check out Qt doc or check our example program

Remarks: In case that your Qt Creator can not recognize QuickAndroid package, you may try to solve it by Tool -> QML/JS -> Reset Code Model

*2. Using DP Unit *

QML can not retrieve the DP unit by itself. Therefore you need to pass the value from C++ source code to QML program.

Please refer to the example program in the folder of [tests/quickandroidexample](tests/quickandroidexample).

Demonstration
-------------

Please refer to the example program in the folder of [tests/quickandroidexample](tests/quickandroidexample)

![Screenshot](https://raw.githubusercontent.com/benlau/quickandroid/master/tests/quickandroidexample/docs/screenshot.png)