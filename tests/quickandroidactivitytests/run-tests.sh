#!/bin/bash

set -e
set -v

adb install -r build/output.apk
cd tests
echo $ANDROID_HOME
./gradlew --version
./gradlew assembleDebug
adb install -r build/outputs/apk/tests-debug-unaligned.apk
adb shell am  instrument -w quickandroid.example.tests/android.test.InstrumentationTestRunner


