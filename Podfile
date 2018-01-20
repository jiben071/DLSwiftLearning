# Uncomment the next line to define a global platform for your project
# use_frameworks!表示将使用框架来代替静态库
# 想要在Swift中使用CocoaPods，你必须明确的写出use_frameworks! 来选择使用框架。如果你忘了写这个，CocoaPods能检测到你使用使用Swift CocoaPods，你安装pods的时候就会报错。
# 因为swift不允许静态库
platform :ios, '9.0'
target 'DLSwiftLearning' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 4.5.0'
  pod 'MBProgressHUD', '~> 1.0.0'

  # Pods for DLSwiftLearning
  
  target 'DLSwiftLearningTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.3'
  end

  target 'DLSwiftLearningUITests' do
    inherit! :search_paths
    # Pods for testing

  end

end
