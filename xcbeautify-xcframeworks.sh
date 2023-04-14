BUILD_DIR=$(dirname "$PWD")/mly-stream-sdk/xc
PROJECT=$PWD/Example/MLYSDK.xcworkspace
TARGET_DIR=$(dirname "$PWD")/mly-stream-sdk/archives

rm -Rf $TARGET_DIR

mkdir -p $BUILD_DIR

mkdir -p $TARGET_DIR

################ Build  SDK

xcodebuild clean -workspace $PROJECT -scheme MLYSDK

# -arch x86_64 arm64\    MACH_O_TYPE=staticlib  VALID_ARCHS=x86_64 \  ONLY_ACTIVE_ARCH=NO
xcodebuild archive \
    -arch x86_64 \
    -workspace $PROJECT \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphonesimulator \
    -destination='generic/platform=iOS Simulator' \
    -archivePath $BUILD_DIR/MLYSDK.iOS-simulator.xcarchive \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# VALID_ARCHS=arm64 \   ONLY_ACTIVE_ARCH=YES -arch arm64 \
xcodebuild archive \
    -workspace $PROJECT \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphoneos \
    -destination='generic/platform=iOS' \
    -archivePath $BUILD_DIR/MLYSDK.iOS.xcarchive \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

 #  -framework "$BUILD_DIR/MLYSDK.iOS-simulator.xcarchive/Products/Library/Frameworks/MLYSDK.framework" -output "$TARGET_DIR/MLYSDK.xcframework" \
xcodebuild -create-xcframework   -framework "$BUILD_DIR/MLYSDK.iOS.xcarchive/Products/Library/Frameworks/MLYSDK.framework" \
                                 -framework "$BUILD_DIR/MLYSDK.iOS-simulator.xcarchive/Products/Library/Frameworks/MLYSDK.framework" -output "$TARGET_DIR/MLYSDK.xcframework" \
                                | xcbeautify

rm -Rf $BUILD_DIR
 
# #依赖
# cp -af Example/Pods/GoogleWebRTC/Frameworks/frameworks/WebRTC.framework $TARGET_DIR
# rm -rf $TARGET_DIR/WebRTC.xcframework/ios-*-simulator 

open $TARGET_DIR