#!/bin/bash

set -e
cd tests
ant debug
adb install -r bin/QAActivityTests-debug-unaligned.apk
adb shell am  instrument -w quickandroid.example.tests/android.test.InstrumentationTestRunner


