# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def alamofire
  pod 'Alamofire', '~> 4.7'
  pod 'RxAlamofire'
end

target 'musicpeeker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for musicpeeker
  alamofire

  target 'musicpeekerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'musicpeekerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
