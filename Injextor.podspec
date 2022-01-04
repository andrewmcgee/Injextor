Pod::Spec.new do |s|
  s.name             = 'Injextor'
  s.version          = '0.1.0'
  s.summary          = 'A simple way to handle dependency injection using property wrappers.'
  s.homepage         = 'https://github.com/andrewmcgee/Injextor'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew McGee' => 'andrew.mcgee@hotmail.co.uk' }
  s.source           = { :git => 'https://github.com/andrewmcgee/Injextor.git', :tag => s.version.to_s }
  s.platforms = { :ios => "13.0", :osx => "10.15", :watchos => "6.0", :tvos => "13.0" }
  s.swift_version = '5.0'
  s.source_files = 'Sources/Injextor/**/*'
end
