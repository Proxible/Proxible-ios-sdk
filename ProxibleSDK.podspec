Pod::Spec.new do |s|
  s.name     = 'ProxibleSDK'
  s.version  = '0.0.1'
  s.license      = {
    :type => 'Commercial',
    :text => <<-LICENSE
              All text and design is copyright © 2013-2014 Proxible B.V.

              All rights reserved.

              https://proxible.com
    LICENSE
  }
  s.summary  = 'BlueCatsSDK for micro-location.'
  s.homepage = 'http://www.proxible.com'
  s.authors   = { 'Proxible' => 'conrad@proxible.com' }
  s.source   = { :git => 'https://github.com/Proxible/Proxible-ios-sdk.git', :tag => '0.0.1' }
  s.platform = :ios, '7.0'
  s.source_files = 'Headers/*.h'
  s.resource = 'ProxibleSDK.bundle'
  s.preserve_paths = 'libProxibleSDK.a'
  s.library = 'ProxibleSDK'
  
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.frameworks = 'CoreBluetooth', 'CoreLocation'
  
  s.xcconfig  =  { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/ProxibleSDK/"' }

  s.ios.dependency 'AFNetworking', '~> 2.1.0'
  s.ios.dependency 'MagicalRecord', '~> 2.2'
end