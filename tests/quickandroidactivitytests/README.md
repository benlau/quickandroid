

Instruction of build
====================

1. Setup environment variable

QT_HOME=
ANDROID_SDK_ROOT=
ANDROID_NDK_ROOT=

2. Run ./run-build.sh

3. Install the generated apk

adb install -r build-apk/android-source/bin/QtApp-debug-unaligned.apk

4. Run ./run-tests.sh


Reference
=========

Command to execute a single test case.

$ adb shell am  instrument -w -e class quickandroid.example.ExampleActivityTest#testSendMessage  quickandroid.example.tests/android.test.InstrumentationTestRunner

List instrumentation
$ adb shell pm list instrumentation


