# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PiperChat' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PiperChat
  pod 'Alamofire'
  pod 'SnapKit'
  pod 'Socket.IO-Client-Swift', '~> 9.0.1'
  pod 'RealmSwift'
  pod 'SDWebImage'
  pod 'Material'
  pod 'SlackTextViewController'
  target 'PiperChatTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PiperChatUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.1'
    end
  end
end
