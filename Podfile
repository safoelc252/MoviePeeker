# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def rx_swift
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxGesture'
  pod 'RxDataSources'
end
def alamofire
  pod 'RxAlamofire'
end
def json
  pod 'ObjectMapper', '~> 3.4'
  pod 'SwiftyJSON'
end

def display
  pod 'SDWebImage', '~> 5.0'
  pod 'Material', '~> 3.1.0'
end

target 'musicpeeker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for musicpeeker
  rx_swift
  alamofire
  json
  display

  target 'musicpeekerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'musicpeekerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
