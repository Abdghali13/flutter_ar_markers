Pod::Spec.new do |s|
  s.name             = 'flutter_ar_markers'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for AR markers integration.'
  s.description      = 'This plugin integrates AR markers with HDAugmentedReality.'
  s.homepage         = 'https://github.com/your-repo/flutter_ar_markers'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Abdalmohsen Abughali' => 'abdalmohsen.abughali@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*.{h,m,swift}'
  s.ios.deployment_target = '12.0'

  # Dependency for HDAugmentedReality
  s.dependency 'HDAugmentedReality'

  # Flutter dependency
  s.dependency 'Flutter'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework Flutter' }
  s.swift_version = '5.0'
  s.vendored_frameworks = 'Flutter.framework'
end
