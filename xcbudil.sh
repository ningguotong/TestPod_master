# 清理项目
xcodebuild clean -workspace YourWorkspace.xcworkspace -scheme YourSchemeName

# 生成真机的 xcarchive
xcodebuild archive -workspace YourWorkspace.xcworkspace -scheme YourSchemeName -destination='generic/platform=iOS' -archivePath './archives/ios.xcarchive' -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# 生成模拟器的 xcarchive
xcodebuild archive -workspace YourWorkspace.xcworkspace -scheme YourSchemeName -destination='generic/platform=iOS Simulator' -archivePath './archives/sim.xcarchive' -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# 合并真机和模拟器的 xcframework
xcodebuild -create-xcframework -framework './archives/ios.xcarchive/Products/Library/Frameworks/YourFramework.framework' -framework './archives/sim.xcarchive/Products/Library/Frameworks/YourFramework.framework' -framework './GoogleWebRTC.xcframework' -output './MyPodRTCLib.xcframework'

# 验证 xcframework 是否包含真机和模拟器的架构
xcodebuild -show-sdks | grep iphoneos | awk '{print $4}' | while read sdk; do
  xcrun lipo -info "./MyPodRTCLib.xcframework/ios/$sdk/MyPodRTCLib.framework/MyPodRTCLib"
done
xcodebuild -show-sdks | grep iphonesimulator | awk '{print $4}' | while read sdk; do
  xcrun lipo -info "./MyPodRTCLib.xcframework/ios-simulator/$sdk/MyPodRTCLib.framework/MyPodRTCLib"
done

# 验证 xcframework 是否包含 GoogleWebRTC.xcframework
otool -L "./MyPodRTCLib.xcframework/ios/$(xcodebuild -show-sdks | grep iphoneos | awk '{print $4}')/MyPodRTCLib.framework/MyPodRTCLib" | grep "GoogleWebRTC.xcframework"
otool -L "./MyPodRTCLib.xcframework/ios-simulator/$(xcodebuild -show-sdks | grep iphonesimulator | awk '{print $4}')/MyPodRTCLib.framework/MyPodRTCLib" | grep "GoogleWebRTC.xcframework"

# 验证是否可以导入 xcframework
xcrun simctl list devices --json | jq -r '.devices[].udid' | while read udid; do
  xcrun simctl install booted "./MyPodRTCLib.xcframework" # 请注意：你需要在 booted 设备中添加你的 app
  xcrun simctl launch booted YourAppBundleIdentifier
done

# 验证 podspec 文件是否正确
pod spec lint YourPodspecFileName.podspec

# 将新的 xcframework 上传到 Cocoapods
pod trunk push YourPodspecFileName.podspec


Pod::Spec.new do |s|
  s.name             = 'MyPod'
  s.version          = '1.0.0'
  s.summary          = 'A brief description of MyPod.'
  s.homepage         = 'https://github.com/yourusername/MyPod'
  s.license          = 'MIT'
  s.author           = { 'Your Name' => 'youremail@example.com' }
  s.source           = { :git => 'https://github.com/yourusername/MyPod.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  
  # 指定 xcframework 文件的路径
  s.vendored_frameworks = 'MyPod.xcframework'
  
  # 指定 xcframework 文件的类型
  s.preserve_paths = 'MyPod.xcframework/**/*'
  
  # 指定 xcframework 文件的依赖项
  s.dependency 'Dependency1'
  s.dependency 'Dependency2'
  
  # 其他设置
  s.requires_arc = true
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
end



xcodebuild -create-xcframework \
-framework <path-to-framework-iphoneos> \
-static \
-output <path-to-output>/MyFramework-iphoneos.xcframework




Pod::Spec.new do |s|
  s.name             = 'MyPod'
  s.version          = '1.0.0'
  s.summary          = 'A brief description of MyPod.'
  s.homepage         = 'https://github.com/yourusername/MyPod'
  s.license          = 'MIT'
  s.author           = { 'Your Name' => 'youremail@example.com' }
  s.source           = { :git => 'https://github.com/yourusername/MyPod.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  
  # 指定 xcframework 文件的路径
  s.vendored_frameworks = 'MyPod.xcframework'
  
  # 指定静态库的位置，并将其链接到 xcframework 中
  s.preserve_paths = 'MyPod.xcframework/**/*', 'MyStaticLibrary.a'
  s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/MyPod', 'OTHER_LDFLAGS' => '-ObjC -lMyStaticLibrary' }
  
  # 指定 xcframework 文件的依赖项
  s.dependency 'Dependency1'
  s.dependency 'Dependency2'
  
  # 其他设置
  s.requires_arc = true
end





$ rm -rf ~/Library/Developer/Xcode/DerivedData

$ xcodebuild archive \
            -scheme MyFramework \
            -destination 'generic/platform=iOS' \
            -archivePath build/MyFramework.xcarchive \
            -sdk iphoneos \
            BUILD_LIBRARY_FOR_DISTRIBUTION=YES

$ xcodebuild archive \
            -scheme MyFramework \
            -destination 'generic/platform=iOS Simulator' \
            -archivePath build/MyFramework.xcarchive \
            -sdk iphonesimulator \
            BUILD_LIBRARY_FOR_DISTRIBUTION=YES

$ xcodebuild -create-xcframework \
            -framework build/MyFramework.xcarchive/Products/Library/Frameworks/MyFramework.framework \
            -framework path/to/GoogleWebRTC.xcframework \
            -output MyFramework.xcframework



Pod::Spec.new do |s|
  # 其他设置
  s.vendored_frameworks = 'MyFramework.xcframework', 'GoogleWebRTC.xcframework'
  # 其他设置
end

