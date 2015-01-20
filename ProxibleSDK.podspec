Pod::Spec.new do |s|
  s.name     = 'ProxibleSDK'
  s.version  = '0.0.13'
  s.license      = {
    :type => 'Commercial',
    :text => <<-LICENSE
              All text and design is copyright © 2013-2014 Proxible B.V..

              All rights reserved.

              https://www.proxible.com
    LICENSE
  }
  s.summary  = 'ProxibleSDK for micro-location.'
  s.homepage = 'http://www.proxible.com'
  s.authors  = { 'Proxible' => 'conrad@proxible.com' }
  s.source   = { :git => 'https://github.com/Proxible/Proxible-ios-sdk.git', :tag => '0.0.13' }

  s.platform     = :ios, '7.0'

  s.source       = { :git => 'https://github.com/Proxible/Proxible-ios-sdk', :tag => s.version.to_s }
  s.source_files = 'ProxibleSDK.framework/Versions/A/Headers/*.h'
  s.ios.vendored_frameworks = 'ProxibleSDK.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited)' }
  s.preserve_paths = 'ProxibleSDK.framework'
  s.resources ='ProxibleSDK.bundle'
  s.frameworks = 'CoreLocation','CoreData','CoreBluetooth'

  s.requires_arc = true

  s.ios.dependency 'AFNetworking', '~> 2.2.3'
  s.ios.dependency 'MagicalRecord', '~> 2.2'

end