# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LemonCheck' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for LemonCheck

  pod 'Firebase/Analytics',:modular_headers => true
  pod 'Firebase/Auth',:modular_headers => true
  pod 'Firebase/Core',:modular_headers => true
  pod 'Firebase/Firestore',:modular_headers => true
  pod 'FirebaseDatabase' ,:modular_headers => true
  pod 'Alamofire', '~> 5.1'
  pod 'Toast-Swift', '~> 5.0.1'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
