#!/bin/bash

set -e

adb install -r build-apk/android-source/bin/QtApp-debug-unaligned.apk
cd tests
#ant debug
adb install -r bin/QAActivityTests-debug-unaligned.apk
adb shell am  instrument -w quickandroid.example.tests/android.test.InstrumentationTestRunner


