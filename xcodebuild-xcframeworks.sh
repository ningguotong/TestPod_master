BUILD_DIR=$PWD/xc
PROJECT=$PWD/Example/MLYSDK.xcworkspace
TARGET_DIR=$PWD/archives

# Delete the old stuff
rm -Rf $TARGET_DIR

# Make the build directory
mkdir -p $BUILD_DIR

# Make the target directory
mkdir -p $TARGET_DIR

xcodebuild clean -workspace $PROJECT -scheme MLYSDK

xcodebuild archive \
    -arch x86_64 \
    -workspace $PROJECT \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphonesimulator \
    -archivePath $BUILD_DIR/ios-simulator \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -workspace $PROJECT \
    -scheme MLYSDK  \
    -configuration Release \
    -sdk iphoneos \
    -destination='generic/platform=iOS' \
    -archivePath $BUILD_DIR/ios-device \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -framework $BUILD_DIR/ios-device.xcarchive/Products/Library/Frameworks/MLYSDK.framework \
    -framework $BUILD_DIR/ios-simulator.xcarchive/Products/Library/Frameworks/MLYSDK.framework \
    -output $TARGET_DIR/MLYSDK.xcframework \

rm -Rf $BUILD_DIR
