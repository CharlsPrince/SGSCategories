Pod::Spec.new do |s|
  s.name             = 'SGSCategories'
  s.version          = '0.1.6'
  s.summary          = '常用类别'

  s.homepage         = 'http://112.94.224.243:8081/kun.li/sgscategories/tree/master'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lee' => 'kun.li@southgis.com' }
  s.source           = { :git => 'http://112.94.224.243:8081/kun.li/sgscategories.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SGSCategories/Classes/**/*'
  s.public_header_files = 'SGSCategories/Classes/**/*.{h}'

  s.libraries  = 'z'
  s.frameworks = 'UIKit', 'QuartzCore'
end
