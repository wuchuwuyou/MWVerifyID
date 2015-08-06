//
//  MWRegularExpressionAPI.h
//  MWVerifyID
//
//  Created by Tiny on 15/8/6.
//  Copyright (c) 2015年 Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWRegularExpressionAPI : NSObject
//邮箱
+ (BOOL)validateEmail:(NSString *)email;


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;


//用户名
+ (BOOL) validateUserName:(NSString *)name;


//密码
+ (BOOL) validatePassword:(NSString *)passWord;


//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//整型
+ (BOOL) isPureInt:(NSString *)string;

//邮编
@end

@interface MWRegularExpressionAPI (singleton)

+ (MWRegularExpressionAPI *)singleton;


@end