
Pod::Spec.new do |spec|
 
  spec.name         = "TestPODNingSDK"
  spec.version      = "0.0.24"
  spec.summary      = "A short description of TestPODNingSDK."
 
  spec.description  = <<-DESC
  TODO: Add long description of the pod here.
                   DESC

  spec.homepage     = "https://github.com/ningguotong/TestPod_master"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

 
  spec.author             = { "ningguotong" => "123916376+ningguotong@users.noreply.github.com" } 
  spec.source       = { :git => "https://github.com/ningguotong/TestPod_master.git", :tag => "#{spec.version}" }
 
  # spec.ios.deployment_target = '14.0'
 
  spec.ios.vendored_frameworks = 'archives/MLYSDK.xcframework'

  spec.swift_version = '5.0'

  spec.frameworks = 'AVFoundation','AVKit'
  
  spec.dependency 'Mux-Stats-AVPlayer' , '~> 3.1.0' 
  spec.dependency 'GCDWebServer', '~> 3.5.4'
  spec.dependency 'Sentry', '~> 7.31.3'
  spec.dependency 'GoogleWebRTC', '~> 1.1.32000'
  spec.dependency 'SwiftCentrifuge', '0.5.5'
  spec.dependency 'SwiftProtobuf', '~> 1.0'

   # 其他设置
   spec.requires_arc = true

   spec.platform = :ios,'14.0'

 
end
