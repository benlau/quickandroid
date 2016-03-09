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

Installation Instruction (qpm)
==============================

For user who are already using qpm from [qpm.io](https://qpm.io)

 1) Run `qpm install`
 
    qpm install com.github.benlau.quickandroid
    
 2) Include vendor/vendor.pri in your .pro file

You may skip this step if you are already using qpm

    include(vendor/vendor.pri)

Installation Instruction 
------------------------

 1) Download a release and bundle the folder within your source tree.

 2) Add this line to your profile file(.pro):

    include(quickandroid/quickandroid.pri) # You should modify the path by yourself


Demonstration
-------------

An example program is available in the folder of [tests/quickandroidexample](tests/quickandroidexample) . You may build it by yourself or download the daily build from [drone.io](https://drone.io/github.com/benlau/quickandroid/files) .

Remarks: Daily build for non-master branch may not be working. 

![Screenshot](https://raw.githubusercontent.com/benlau/quickandroid/master/docs/screenshots/example1.png)

Class Reference (Under Construction)
---------------

[Quick Android Class Reference](http://benlau.github.io/quickandroid/)

If you have any question, please feel free to ask.

SystemDispatcher
----------------

Automatic type convertion

| Qt           | Java    |
|--------------|---------|
| int          | int     |
| bool         | boolean |
| QString      | String  |
| QVariantList | List<T> |
| QVariantMap  | Map<T>  |

License
-------

Apache License 2.0

TODO
----

v0.1.7
 1. Migrate to build with gradle
 2. Upgrade min Qt version requirement to 5.5.1

v0.1.8
 1. Upgrade min Qt version requirement to 5.6
 2. Depreate to use A.dp as measurement unit

v1.0 
 1. Switch
 1. NavigationDrawer
 1. Slider

Wish
 1. SwipeableListItem
 2. AssetsManager
 3. Haptic Feedback

FAQ
---

Q. Looking for component that is not supported yet?

Please feel free to submit the request to our issue tracker. Moreover, you may take a look on other component library:

1. [Iktwo/components](https://github.com/Iktwo/components)
2. [rschiang/material](https://github.com/rschiang/material)

Q. Looking for iOS Native Component?

1. [benlau/quickios](https://github.com/benlau/quickios) 

Q. Any library for ...?

1. Sharing
 1. [bdentino/Qtino.SharingKit](https://github.com/bdentino/Qtino.SharingKit)

Q. How to create splash screen for Android?

See [Complete Guide to Making a Splash Screen for your QML Android Application — Medium](https://medium.com/@benlaud/complete-guide-to-make-a-splash-screen-for-your-qml-android-application-567ca3bc70af#.z9biu3sfp)

Related Projects
----------------

 1. [benlau/quickflux](https://github.com/benlau/quickflux) - Message Dispatcher / Queue solution for QML
 1. [benlau/quickpromise](https://github.com/benlau/quickpromise) - Promise library for QML
 1. [benlau/quickcross](https://github.com/benlau/quickcross) - QML Cross Platform Utility Library
 1. [benlau/qsyncable](https://github.com/benlau/qsyncable) - Synchronize data between models
 1. [benlau/testable](https://github.com/benlau/testable) - QML Unit Test Utilities
 1. [benlau/qtci](https://github.com/benlau/qtci) -  A set of scripts to install Qt in Linux command line environment (e.g travis)
