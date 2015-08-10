//
//  MWValidateIDCard.h
//  MWVerifyID
//
//  Created by Tiny on 15/8/7.
//  Copyright (c) 2015年 Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MWUser;

typedef NS_ENUM(NSUInteger, MWUserType) {
    MWUserMale = 1,
    MWUserFemale
};
struct MWIDInfo {
    NSUInteger age;
    MWUserType sex;
    NSUInteger timestamp;
};
/*!
 *  @author Tiny, 2015-08-10 17:08
 *
 *  @brief  目前仅支持18位身份证号码
 */
@interface MWValidateIDCard : NSObject

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;


+ (MWUser *)userInfoWithidentityCard:(NSString *)identityCard;


@end

@interface MWUser : NSObject

@property (nonatomic,assign) MWUserType sex;
@property (nonatomic,assign) NSNumber   *age;
@property (nonatomic,strong) NSDate     *birthday;
@property (nonatomic,strong) NSString   *region;

@end