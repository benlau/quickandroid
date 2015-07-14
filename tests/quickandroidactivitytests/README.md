
1. Setup environment variable

QT_HOME=
ANDROID_SDK_ROOT=
ANDROID_NDK_ROOT=

2. Run ./build.sh

3. Install the generated apk

adb install -r build-apk/android-source/bin/QtApp-debug-unaligned.apk

4. cd tests/

5. ant debug

6. adb install -r bin/QAActivityTests-debug-unaligned.apk



