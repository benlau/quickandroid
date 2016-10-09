Quick Android Setup Guide
=========================

To get components like Image picker to work,
it needs to setup JNI environment and build system to let's it to locate related Java source file correctly.
This document will provide the procedure

Step 1 - JNI_OnLoad
-------------

In you main.cpp, add following lines:

```
#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>

JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void*) {
    Q_UNUSED(vm);
    qDebug("NativeInterface::JNI_OnLoad()");

    // It must call this function within JNI_OnLoad to enable System Dispatcher
    QASystemDispatcher::registerNatives();

    return JNI_VERSION_1_6;
}
#endif

```

Example:
https://github.com/benlau/quickandroid/blob/master/examples/quickandroidexample/main.cpp#L20


Step 2 - Modify your Android activity
-------

If you don't have your own custom Android activity, modify AndroidManifest.xml, change activity.name to "quickandroid.QuickAndroidActivity"

Example:
https://github.com/benlau/quickandroid/blob/master/examples/quickandroidexample/android-sources/AndroidManifest.xml

If you have your own custom Android activity, add following lines to your activity class:

```
import quickandroid.SystemDispatcher;
```

```
@Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        SystemDispatcher.onActivityResult(requestCode,resultCode,data);
    }
```

Example:
https://github.com/benlau/quickandroid/blob/master/java/quickandroid/QuickAndroidActivity.java


Step 3 - Modify the build system
---------

If you are still using ant, that is fine. You may skip this step.

Modify build.gradle:

```
import groovy.json.JsonSlurper

String getAndroidPackageSourceDir() {
    String res = System.getProperty("user.dir");

    FileTree tree = fileTree(dir: res + '/..').include('android*deployment-settings.json');

    if (tree.size() > 0) {
        String json = tree[0];
        def inputFile = new File(json);
        def InputJSON = new JsonSlurper().parseText(inputFile.text);
        res = InputJSON["android-package-source-directory"]
    }

    return res;
}

String androidPackageSourceDir = getAndroidPackageSourceDir();
println("ANDROID_PACKAGE_SOURCE_DIRECTORY:" + androidPackageSourceDir);
```

Include androidPackageSourceDir

```
    sourceSets {
        main {
            manifest.srcFile 'AndroidManifest.xml'
            java.srcDirs = [qt5AndroidDir + '/src', 'src', 'java',
                            androidPackageSourceDir + '/../../../java']
            aidl.srcDirs = [qt5AndroidDir + '/src', 'src', 'aidl']
            res.srcDirs = [qt5AndroidDir + '/res', 'res']
            resources.srcDirs = ['src']
            renderscript.srcDirs = ['src']
            assets.srcDirs = ['assets']
            jniLibs.srcDirs = ['libs']
       }
    }
```

