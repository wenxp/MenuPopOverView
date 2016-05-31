Pod::Spec.new do |s|
  s.name         = "MenuPopOverView"
  s.version      = "0.0.4"
  s.summary      = "A custom PopOverView looks like UIMenuController works on iPhone."
  s.homepage     = "https://github.com/wenxp/MenuPopOverView"
  s.screenshots  = "https://raw.githubusercontent.com/camelcc/MenuPopOverView/master/popOver.png"
  s.license      = 'MIT'
  s.author       = { "wenxp" => "wenxp2006@gmail.com" }
  s.social_media_url = "http://twitter.com/camel_young"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/wenxp/MenuPopOverView.git", :tag => "0.0.4" }
  s.source_files = 'MenuPopOverView'
  s.resources = "MenuPopOverView/*.png"
  s.requires_arc = true
end
