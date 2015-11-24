QML Material Design Component and Support Library for Android
===========================================================
[![Build Status](https://travis-ci.org/benlau/quickandroid.svg?branch=master)](https://travis-ci.org/benlau/quickandroid)

Features
--------

 1. Set of UI components implemented Google's Material Design
  1. Support hardware "Back" key nagivation
  1. Dimension in "dp" unit. Auto-scale according to system's DP value.
  1. Provide page transition animation
 1. Drawable Image provider
  1. Load image resource from Android resource style file tree. (e.g drawable-xxxhdpi)
  2. Tint image at load time
  3. Choose the best image according to current resolution automatically.
 1. Unified “Drawable” component
  1. A single component that supports color , image , QML component, simulated nine patch image as input source
  1. Auto scale image to fit current screen resolution
  1. Derived StateListDrawable for animated drawable like button
 1. Messege queue between C++/Qt and Java/Android code
  1. Auto conversion between C++ and Java data type. No need to write in JNI.
 1. Theme / Style Engine
  1. A global Theme object. Set once for all components.
  1. Helper function to create your own derived style.
 1. "Apache license" - Free to use for commerical application

System Requirements
 1. Qt 5.4 or above

UI Components

    ActionBar , Button , BottomSheet , Drawable , StateListDrawable
    Page , PageStack , MaterialShadow , Text, TextField, DropDownMenu, Paper
    TabBar, TabView, FloatingActionButton, ListItem, RaisedButton

Native Components

    ImagePicker

Utility Components

    InverseMouseArea, RectToRectMatrix, SystemDispatcher, MouseSensor

Installation Instruction 
------------------------

 1) Download a release and bundle the folder within your source tree.

 2) Add this line to your profile file(.pro):

    include(quickandroid/quickandroid.pri) # You should modify the path by yourself

Initalization
-------------

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
    
    // Setup "drawable" image provider
    QADrawableProvider* provider = new QADrawableProvider();
    provider->setBasePath("qrc:///res");
    view.engine()->addImageProvider("drawable",provider)

    /* End of QuickAndroid Initialization */

    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:///splash.qml")));
    view.show();

    return app.exec();
}


```

Import the package within your QML file by :

    import QuickAndroid 0.1


Demonstration
-------------

An example program is available in the folder of [tests/quickandroidexample](tests/quickandroidexample) . You may build it by yourself or download the daily build from [drone.io](https://drone.io/github.com/benlau/quickandroid/files) .

Remarks: Daily build for non-master branch may not be working. 

![Screenshot](https://raw.githubusercontent.com/benlau/quickandroid/master/docs/screenshots/example1.png)

License
-------

Apache License 2.0

TODO
----

v0.1.5
 1. Native Image Picker
 2. Redesign Dialog component in Material Design Style.
 3. BottomSheet

v1.0 
 1. Switch
 1. NavigationDrawer
 1. Slider
 1. Custom page transition effect

Wish
 1. SwipeableListItem
 2. qpm package?

FAQ
---

Q. Looking for component that is not supported yet?

Please feel free to submit the request to our issue tracker. Moreover, you may take a look on other component library:

1. [Iktwo/components](https://github.com/Iktwo/components)
2. [rschiang/material](https://github.com/rschiang/material)

Q. No document?

Just ask. Then the author will try to answer and make it as a document.

Q. Looking for iOS Native Component?

1. [benlau/quickios](https://github.com/benlau/quickios) 

Q. Any library for ...?

1. Sharing
 1. [bdentino/Qtino.SharingKit](https://github.com/bdentino/Qtino.SharingKit)

Related Projects
 1. [benlau/quickpromise](https://github.com/benlau/quickpromise) - Promise library for QML
 2. [benlau/quickflux](https://github.com/benlau/quickflux) - Message Dispatcher / Queue solution for QML

