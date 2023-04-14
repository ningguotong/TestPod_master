PROJEC_TNAME=MLYSDK
BUILD_DIR=$PWD/xc
PROJECT=$PWD/Example/$PROJEC_TNAME.xcworkspace
TARGET_DIR=$PWD/archives


# Delete the old stuff                                                                                                                                                                         
rm -Rf $TARGET_DIR

# Make the build directory                                                                                                                                                                     
mkdir -p $BUILD_DIR
# Make the target directory                                                                                                                                                                    
mkdir -p $TARGET_DIR

################ Build MuxCore SDK                                    

 xcodebuild archive -scheme $PROJEC_TNAME -workspace $PROJECT  -destination "generic/platform=iOS" -archivePath "$BUILD_DIR/$PROJEC_TNAME.iOS.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIB\
UTION=YES CLANG_ENABLE_MODULES=NO MACH_O_TYPE=staticlib | xcbeautify

 xcodebuild archive -scheme $PROJEC_TNAME -workspace $PROJECT  -destination "generic/platform=iOS Simulator" -archivePath "$BUILD_DIR/$PROJEC_TNAME.iOS-simulator.xcarchive" SKIP_INSTALL=NO BUILD\
_LIBRARY_FOR_DISTRIBUTION=YES CLANG_ENABLE_MODULES=NO MACH_O_TYPE=staticlib | xcbeautify
 
 xcodebuild -create-xcframework -framework "$BUILD_DIR/$PROJEC_TNAME.iOS.xcarchive/Products/Library/Frameworks/$PROJEC_TNAME.framework" \
                                -framework "$BUILD_DIR/$PROJEC_TNAME.iOS-simulator.xcarchive/Products/Library/Frameworks/$PROJEC_TNAME.framework" \
                                -output "$TARGET_DIR/$PROJEC_TNAME.xcframework" | xcbeautify

rm -Rf $BUILD_DIR
