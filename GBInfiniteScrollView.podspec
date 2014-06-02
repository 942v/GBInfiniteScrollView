Pod::Spec.new do |s|
  s.name         = "GBInfiniteScrollView"
  s.version      = "1.0"
  s.summary      = "GBInfiniteScrollView class provides an endlessly scroll view organized in pages."
  s.homepage     = "https://github.com/gblancogarcia"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Gerardo Blanco" => "gblancogarcia@gmail.com" }
  s.source       = { :git => "https://github.com/942v/GBInfiniteScrollView.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'GBInfiniteScrollView/GBInfiniteScrollView/*.{h,m}'
  end

  s.subspec 'PageController' do |pc|
    pc.dependency 'GBInfiniteScrollView/Core'
    pc.source_files = 'GBInfiniteScrollView/GBInfiniteScrollView/Optional/PageControllerSubClass/*.{h,m}’
    pc.dependency 'FXPageControl', '~> 1.3.2'
  end

end
