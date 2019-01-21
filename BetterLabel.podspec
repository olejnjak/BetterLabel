Pod::Spec.new do |s|
    s.name             = 'BetterLabel'
    s.version          = '0.1.2'
    s.summary          = 'Simplify styling of UILabel'
    s.description      = <<-DESC
    BetterLabel simplifies setting general styling properties which should normally be handled by NSAttributedString
    DESC
    s.homepage         = 'https://github.com/olejnjak/BetterLabel'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Jakub Olejník' => 'olejnjak@gmail.com' }
    s.social_media_url = "https://twitter.com/olejnjak"
    s.source           = { :git => 'https://github.com/olejnjak/BetterLabel.git', :tag => s.version.to_s }
    s.ios.deployment_target = '9.0'
    s.source_files     = 'BetterLabel/*.swift'
    s.swift_version    = '4.2.1'
end
