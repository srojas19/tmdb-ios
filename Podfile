# Uncomment the next line to define a global platform for your project
 platform :ios, '12.2'

target 'TMDb' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TMDb
  pod 'RealmSwift'
  pod 'ObjectMapper', '~> 3.4'
  pod 'ObjectMapperAdditions/Realm', '~> 6.0'
  pod 'Kingfisher' ### , '~> 5.0'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'

  target 'TMDbTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RealmSwift'
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

  target 'TMDbUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
