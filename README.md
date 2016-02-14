#MWIDCardValidate（身份证验证）

[![version](https://img.shields.io/cocoapods/v/MWIDCardValidate.svg)](https://img.shields.io/cocoapods/v/MWIDCardValidate.svg)
[![License](https://img.shields.io/cocoapods/l/MWIDCardValidate.svg)](https://github.com/wuchuwuyou/MWVerifyID/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/MWIDCardValidate.svg)](https://img.shields.io/cocoapods/p/MWIDCardValidate.svg)
##Installation
###CocoaPods
	#Your Podfile
	platform :ios, '7.0'
	pod 'MWIDCardValidate', '~> 1.0.0'
###Usage
`验证身份证号`

	BOOL isValidate = [MWIDCardValidate validateIdentityCard:IDNumber];
	
###Licenses
MIT License