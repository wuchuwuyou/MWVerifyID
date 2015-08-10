//
//  MWValidateIDCard.m
//  MWVerifyID
//
//  Created by Tiny on 15/8/7.
//  Copyright (c) 2015年 Murphy. All rights reserved.
//

#import "MWValidateIDCard.h"

//六位数字地址码，八位数字出生日期码，三位数字顺序码和一位数字校验码。
//static NSUInteger addressLen  = 6;
//static NSUInteger birthdayLen = 8;
//static NSUInteger sxCodeLen = 3;
/*
 1、将前面的身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。
 2、将这17位数字和系数相乘的结果相加。
 3、用加出来和除以11，看余数是多少？
 4、余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字。其分别对应的最后一位身份证的号码为1－0－X －9－8－7－6－5－4－3－2。
 5、通过上面得知如果余数是3，就会在身份证的第18位数字上出现的是9。如果对应的数字是2，身份证的最后一位号码就是罗马数字x。
 例如：某男性的身份证号码为【53010219200508011x】， 我们看看这个身份证是不是合法的身份证。
 首先我们得出前17位的乘积和【(5*7)+(3*9)+(0*10)+(1*5)+(0*8)+(2*4)+(1*2)+(9*1)+(2*6)+(0*3)+(0*7)+(5*9)+(0*10)+(8*5)+(0*8)+(1*4)+(1*2)】是189，然后用189除以11得出的结果是189/11=17----2，也就是说其余数是2。最后通过对应规则就可以知道余数2对应的检验码是X。所以，可以判定这是一个正确的身份证号码。
 */
@interface MWValidateIDCard ()
@property (nonatomic,strong) NSArray *validateCode;
@property (nonatomic,strong) NSArray *digits;
@property (nonatomic,strong) NSDictionary *zoneCode;
@end

@implementation MWValidateIDCard

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    return [[self alloc] validateIDCard:identityCard];
}
- (BOOL)validateIDCard:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if ([identityCardPredicate evaluateWithObject:identityCard]) {
        if ([self checkCode:identityCard]) {
            return YES;
        }
    }
    return NO;
}


- (MWUser *)userWithIDCard:(NSString *)card{
    if (![self validateIDCard:card]) {
        NSLog(@"身份证号码错误");
        return nil;
    }
    NSInteger year = [[card substringWithRange:NSMakeRange(6, 4)] integerValue];
    NSInteger month = [[card substringWithRange:NSMakeRange(10, 2)] integerValue];
    NSInteger day = [[card substringWithRange:NSMakeRange(12, 2)] integerValue];
    
//    NSString *code = [card substringWithRange:NSMakeRange(0, 2)];
    
    NSInteger gender = [[card substringWithRange:NSMakeRange(16, 1)] integerValue];
    NSString *genderStr;
    MWUser *user = [[MWUser alloc] init];
    if (fmod(gender, 2)){
        genderStr = NSLocalizedString(@"男", @"male");
        user.sex = MWUserMale;
    }
    else{
        genderStr = NSLocalizedString(@"女", @"female");
        user.sex = MWUserFemale;
    }
    
    NSString *zone = [card substringWithRange:NSMakeRange(0, 6)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:GTMzone];
    NSDate * date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%zd-%zd-%zd",year,month,day]];
    
    date = [NSDate dateWithTimeInterval:3600 sinceDate:date];
    [dateFormatter setTimeZone:localzone];
    user.birthday = date;
    
    NSString * reg = [self.zoneCode objectForKey:zone];
    
    user.region = reg;
    
    return user;
}
+ (MWUser *)userInfoWithidentityCard:(NSString *)identityCard{
    return [[self alloc] userWithIDCard:identityCard];
}



- (NSArray *)validateCode{
    return @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
}

- (NSArray *)digits{
    return @[@1, @0, @10, @9, @8, @7, @6, @5, @4, @3, @2];
}

- (NSDictionary *)zoneCode{
    if (!_zoneCode) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ZoneCode" ofType:@"json"];
        NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
        _zoneCode = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    }
    return _zoneCode;
}

- (BOOL)checkCode:(NSString *)code{
    NSInteger sum = 0;
    for (NSInteger i = 0; i < self.validateCode.count; i++) {
        sum += ((NSNumber *)self.validateCode[i]).integerValue * [code substringWithRange:NSMakeRange(i, 1)].integerValue;
    }
    int remainder = fmod(sum, 11);
    
    NSString *last = [code substringFromIndex:code.length-1];
    
    if ([[last lowercaseString] isEqual:@"x"]) {
        last = @"10";
    }
    NSInteger lastNum = last.integerValue;
    
    if (((NSNumber *)self.digits[remainder]).integerValue == lastNum) {
        return YES;
    }else{
        return NO;
    }
}


@end



@implementation MWUser

- (NSNumber *)age{
    NSDate *date = _birthday;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date toDate:[NSDate date] options:0];
    
    return @(d.year);
}
- (NSString *)description{
    
    return [NSString stringWithFormat:@"sex:%@,birthday:%@,region:%@,age:%@",self.sex == MWUserMale?@"男":@"女",self.birthday,self.region,self.age];
}
- (NSString *)debugDescription{
    
    return [NSString stringWithFormat:@"sex:%@,birthday:%@,region:%@,age:%@",self.sex == MWUserMale?@"男":@"女",self.birthday,self.region,self.age];
}

@end