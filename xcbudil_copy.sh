BUILD_DIR=$(dirname "$PWD")/mly-stream-sdk/xc
PROJECT=$PWD/Example/MLYSDK.xcworkspace
TARGET_DIR=$(dirname "$PWD")/mly-stream-sdk/archives


# Delete the old stuff
rm -Rf $TARGET_DIR

# Make the build directory
mkdir -p $BUILD_DIR
# Make the target directory
mkdir -p $TARGET_DIR

################ Build  SDK

xcodebuild clean -workspace $PROJECT -scheme MLYSDK

xcodebuild archive \
    -arch x86_64 \
    -workspace $PROJECT \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphonesimulator \
    -archivePath $BUILD_DIR/MLYSDK.iOS-simulator.xcarchive \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

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

 
xcodebuild -create-xcframework   -framework "$BUILD_DIR/MLYSDK.iOS.xcarchive/Products/Library/Frameworks/MLYSDK.framework" \
                                 -framework "$BUILD_DIR/MLYSDK.iOS-simulator.xcarchive/Products/Library/Frameworks/MLYSDK.framework" \
                                -output "$TARGET_DIR/MLYSDK.xcframework" \
                                | xcbeautify

rm -Rf $BUILD_DIR
