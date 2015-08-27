//
//  MWIDCardValidate.h
//  MWVerifyID
//
//  Created by Murphy on 15/8/27.
//  Copyright (c) 2015年 Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWIDCardValidate : NSObject
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
@end
