Pod::Spec.new do |s|
  s.name             = 'ANActivityIndicator'
  s.version          = '1.2.0'
  s.summary          = 'ANActivityIndicator is pre-built indicator animations library written in Swift 5.'

  s.description      = <<-DESC
ANActivityIndicator is pre-built indicator animations library written in Swift4. You can easily create and show indicators locally or globally. Also you can create custom animations.
                       DESC

  s.homepage         = 'https://github.com/anelad/ANActivityIndicator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arda Oğul Üçpınar' => 'info@ardaucpinar.com' }
  s.source           = { :git => 'https://github.com/anelad/ANActivityIndicator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ArdaUcpinar'

  s.ios.deployment_target = '9.0'
  s.platform = :ios, '9.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'Source/Classes/**/*'

end
