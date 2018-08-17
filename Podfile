# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'TIMII' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Firebase
  #pod 'FirebaseUI'
  #pod 'FirebaseUI/Storage'
  #pod 'FirebaseUI/Auth'
  #pod 'FirebaseUI/Google'
  
  # Pods for TIMII
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'
  pod 'Firebase/Performance'

  # Pods for TIMII testing use
  target 'TIMIITests' do
    inherit! :search_paths
    pod 'Firebase/Core'
  end

  # Pods for Autolayout Library SnapKit
  # pod 'SnapKit', '~> 4.0.0'
  
  # Pod for Swift Layout Framework
  pod 'Layout', '~> 0.6'

end
