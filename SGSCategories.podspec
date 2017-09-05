Pod::Spec.new do |s|
  s.name             = 'SGSCategories'
  s.version          = '0.1.7'
  s.summary          = '常用类别'

  s.homepage         = 'https://github.com/CharlsPrince/SGSCategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CharlsPrince' => '961629701@qq.com' }
  s.source           = { :git => 'https://github.com/CharlsPrince/SGSCategories.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SGSCategories/Classes/**/*'
  s.public_header_files = 'SGSCategories/Classes/**/*.{h}'

  s.libraries  = 'z'
  s.frameworks = 'UIKit', 'QuartzCore'
end
