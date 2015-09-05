#
#  Be sure to run `pod spec lint MWIDCardValidate.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "MWIDCardValidate"
  s.version      = "1.0.0"
  s.summary      = "居民身份证验证"
  s.description  = <<-DESC
                   This is ID card validate for chinese.
                   中华人民共和国居民身份证验证
                   DESC
  s.homepage     = "https://github.com/wuchuwuyou/MWVerifyID"
  s.license      = "MIT"
  s.author             = { "Murphy" => "tinynorth@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/wuchuwuyou/MWVerifyID.git", :tag => "1.0.0" }
  s.source_files  = "MWIDCardValidate/*"
end
