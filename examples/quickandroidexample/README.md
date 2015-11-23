Quick Android Example Program
=============================

Pre-built Binary
----------------

[Download](https://drone.io/github.com/benlau/quickandroid/files)

Remarks: Daily build for non-master branch may not be working.



Prerequisites
-------------

 * Qt Android SDK >= 5.3.0
 * Android SDK

Check this article for how to setup Qt and Android SDK:

[Getting Started with Qt for Android](http://qt-project.org/doc/qt-5/androidgs.html)

Build Instruction
-----------------

 1. Open quickandroidexample.pro by Qt Creator
 1. Press the "Projects" tab. Make sure the "Android for xxx" kit has been selected
 1. Plug a Android device to your computer
 1. Press "Build" -> "Run"
 1. The program will be deployed to your device. It is so easy!

![Screenshot](https://raw.githubusercontent.com/benlau/quickandroid/master/tests/quickandroidexample/docs/screenshot.png)

FAQ
---

1) How to prevent to show a scene with only application title on startup?

Add the following attribute to AndroidManifest.xml within activity tag

```
android:theme="@android:style/Theme.Black.NoTitleBar"
```
