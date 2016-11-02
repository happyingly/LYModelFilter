#
#  Be sure to run `pod spec lint LYModelFilter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LYModelFilter"
  s.version      = "1.0.0"
  s.summary      = "LYModelFilter makes it easy to deal with Array data such as mapping, filtering, comparing."
  # s.description  = "LYModelFilter makes it easy to deal with Array data such as mapping, filtering, comparing."

  s.homepage     = "https://github.com/happyingly/LYModelFilter"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  s.author             = { "LongYi" => "joylong.ly@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/happyingly/LYModelFilter.git", :tag => "#{s.version}" }

  s.source_files  = "LYModelFilter/LYModelFilter/*.{h,m}"


  # s.public_header_files = "Classes/**/*.h"
  s.framework  = "Foundation"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
