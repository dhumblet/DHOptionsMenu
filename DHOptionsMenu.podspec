#
#  Be sure to run `pod spec lint DHOptionsMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "DHOptionsMenu"
  s.version      = "1.0.1"
  s.platform     = :ios, '7.0'
  s.summary      = "An Android inspired options menu for iOS."
  s.description  = "A dropdown options menu that can be called from any UIView component."
  s.homepage     = "https://github.com/dhumblet/DHOptionsMenu"
  s.screenshots  = "https://raw.githubusercontent.com/dhumblet/DHOptionsMenu/master/Screenshot.png"
  s.license      = "MIT"
  s.author       = { "Derk Humblet" => "derk.humblet@gmail.com" }
  s.source       = { :git => "https://github.com/dhumblet/DHOptionsMenu.git", :tag => "#{s.version}" }
  s.source_files = "DHOptionsMenu", "DHOptionsMenu/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  s.requires_arc = true
end
