# Uncomment the next line to define a global platform for your project
platform :ios, '12.1'
use_frameworks!
inhibit_all_warnings!

def shared_pods
  pod 'Alamofire'
  pod 'RxSwift'
  pod 'SnapKit'
  pod 'Kingfisher'
end

target 'Movies' do
  shared_pods
end

target 'MoviesTests' do
#  inherit! :search_paths
  # Pods for testing
  shared_pods
  pod 'RxBlocking'
  pod 'RxTest'
end

