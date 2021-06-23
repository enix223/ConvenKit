Pod::Spec.new do |s|
  s.name             = 'ConvenKit'
  s.version          = '0.1.0'
  s.summary          = 'ObjC useful helper class stuff'
  s.description      = 'ObjC useful helper class stuff'

  s.homepage         = 'https://github.com/enix223/ConvenKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enix Yu' => 'enix223@163.com' }
  s.source           = { :git => 'https://github.com/enix223/ConvenKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'ConvenKit/Classes/**/*'
end
