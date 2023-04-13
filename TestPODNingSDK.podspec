
Pod::Spec.new do |spec|
 
  spec.name         = "TestPODNingSDK"
  spec.version      = "0.0.14"
  spec.summary      = "A short description of TestPODNingSDK."
 
  spec.description  = <<-DESC
  TODO: Add long description of the pod here.
                   DESC

  spec.homepage     = "https://github.com/ningguotong/TestPod_master"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

 
  spec.author             = { "ningguotong" => "123916376+ningguotong@users.noreply.github.com" } 
  spec.source       = { :git => "https://github.com/ningguotong/TestPod_master.git", :tag => "#{spec.version}" }

  # spec.swift_version = '5.0'
  
  spec.ios.deployment_target = '14.0'
 
  spec.ios.vendored_frameworks = 'archives/MLYSDK.xcframework'

# spec.public_header_files = 'Pod/Classes/**/*.h'

  # spec.pod_target_xcconfig = {
  #   'VALID_ARCHS'=>'arm64 x86_64',
  #   'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64',
  #   'ENABLE_BITCODE' => 'NO',
  #   'OTHER_LDFLAGS' => '$(inherited) -framework WebRTC -ObjC',
  #   'FRAMEWORK_SEARCH_PATHS' => '$(inherited)'
  # }
  # spec.user_target_xcconfig = { 
  #   'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' 
  # }

  spec.frameworks = 'AVFoundation','AVKit'
  
  spec.dependency 'Mux-Stats-AVPlayer', '~> 3.1.0'
  spec.dependency 'GCDWebServer', '~> 3.5.4'
  spec.dependency 'Sentry', '~> 7.31.3'
  spec.dependency 'GoogleWebRTC'
  spec.dependency 'SwiftCentrifuge'
  spec.dependency 'SwiftProtobuf', '~> 1.0'

   # 其他设置
   spec.requires_arc = true

  #  spec.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }



  # spec.pod_target_xcconfig = { 
#   'VALID_ARCHS' => 'x86_64 arm64', 'ENABLE_BITCODE' => 'NO'
# }


  # spec.pod_target_xcconfig = { 
  #   'VALID_ARCHS' => 'x86_64 armv7 arm64', 'ENABLE_BITCODE' => 'NO'
    # 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' 
  # }

  # spec.user_target_xcconfig = { 
    # 'VALID_ARCHS' => 'x86_64 armv7 arm64', 'ENABLE_BITCODE' => 'NO'
    # 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' 
  #  } 

  # spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' } 

  # spec.pod_target_xcconfig = {
  #       'KOTLIN_TARGET[sdk=iphonesimulator*]' => 'ios_x86_64',
  #       'KOTLIN_TARGET[sdk=iphoneos*]' => 'ios_arm'
  #  }
  
  # spec.pod_target_xcconfig = {
  #   'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64'
  # }
  # spec.user_target_xcconfig = {
  #   'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  # }

  # spec.static_framework = true

  
end
