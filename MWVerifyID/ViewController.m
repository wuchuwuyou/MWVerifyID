//
//  ViewController.m
//  MWVerifyID
//
//  Created by Tiny on 15/8/4.
//  Copyright (c) 2015年 Murphy. All rights reserved.
//

#import "ViewController.h"
#import "MWValidateIDCard.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    ///exp
    NSArray *arr = @[@"361123197804117614",
                    @"513431197611287655",
                    @"431300198509122056",
                    @"441502198306303434",
                    @"130107197602013476",
                    @"32132219790318451X",
                    @"440300197708062611",
                    @"370126197908129133",
                    @"350524198107178330",
                    @"451001198402062333",
                    @"14000019850620923X",
                    @"220300198301032991",
                    @"640121198201163096",
                    @"350525198411274593",
                     @"152525197807123097"];
    
    for (NSString *code in arr) {
        if ([MWValidateIDCard validateIdentityCard:code]) {
            NSLog(@"身份证验证通过");
        }else{
            NSLog(@"身份证验证不通过");
        }
        MWUser *user =  [MWValidateIDCard userInfoWithidentityCard:code];
        NSLog(@"%@",user);

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
