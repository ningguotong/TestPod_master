
Pod::Spec.new do |spec|
 
  spec.name         = "TestPODSDK"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of TestPODSDK."
 
  spec.description  = <<-DESC
                   DESC

  spec.homepage     = "https://github.com/ningguotong/TestPod_master"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
 
  spec.license      = "MIT (TestPod_master)"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

 
  spec.author             = { "ningguotong" => "123916376+ningguotong@users.noreply.github.com" } 
  spec.source       = { :git => "https://github.com/ningguotong/TestPod_master.git", :tag => "#{spec.version}" }


  spec.swift_version = '5.0'
  
  spec.ios.deployment_target = '14.0'
 
  spec.ios.vendored_frameworks = 'archives/MLYSDK.xcframework' 

# spec.public_header_files = 'Pod/Classes/**/*.h'

# spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64', 'ENABLE_BITCODE' => 'NO' }
  
  spec.frameworks = 'AVFoundation'
    
  spec.dependency 'Mux-Stats-AVPlayer', '~> 3.1.0'
  spec.dependency 'GCDWebServer', '~> 3.5.4'
  spec.dependency 'Sentry', '~> 7.31.3'
  spec.dependency 'GoogleWebRTC'
  spec.dependency  'SwiftCentrifuge'
  spec.dependency  'SwiftProtobuf', '~> 1.0'
  
end
