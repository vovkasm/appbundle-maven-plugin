#!/bin/sh

CC=clang

if [[ -z "$JAVA_HOME" ]]; then
    JAVA_HOME=`/usr/libexec/java_home`
fi

INCLUDE="-I ${JAVA_HOME}/include -I ${JAVA_HOME}/include/darwin"
FRAMEWORK="-framework Cocoa"
SRC="native/main.m"
DST="src/main/resources/sh/tak/appbundler/JavaAppLauncher"

# SDK
for sdk in /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
do
	if [ -d $sdk ]
	then
		SDK=$sdk
		break
	fi
done
ARCH="x86_64"
MIN_MAC_OSX_VERSION="10.7"
set -x
$CC -o $DST $FRAMEWORK $INCLUDE -arch $ARCH -isysroot $SDK -mmacosx-version-min=$MIN_MAC_OSX_VERSION $SRC
