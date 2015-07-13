#!/bin/bash

set -e

checkenv() {
  set +e
  value=`printenv $1`
  set -e

  if [ -z "$value" ] 
  then
     echo "$1 environment variable is not set"
     exit -1;
  fi

}

checkenv "USER";
checkenv "QT_HOME";
checkenv "ANDROID_SDK_ROOT";
checkenv "ANDROID_NDK_ROOT"

PLATFORM=android_armv7

QT_ANDROID_BIN=$QT_HOME/$PLATFORM/bin
QMAKE=$QT_ANDROID_BIN/qmake
ANDROID_BUILD_DIR=$PWD/build/android

mkdir -p build;
cd build;
$QMAKE ../../../examples/quickandroidexample
make 
make install INSTALL_ROOT=$ANDROID_BUILD_DIR
$QT_ANDROID_BIN/androiddeployqt --input android-libquickandroidexample.so-deployment-settings.json --release --output $ANDROID_BUILD_DIR
