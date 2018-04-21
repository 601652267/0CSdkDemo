//
//  ViewController.m
//  HaierMedicApp
//
//  Created by 朱海铭 on 2018/4/20.
//  Copyright © 2018年 朱海铭. All rights reserved.
//

#import "ViewController.h"
#import <anXingBaoSDK/anXingBaoSDK-Swift.h>
#import "CustomViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[[AXBSDK alloc] init] apiKeyWithKey:@"6649E047900DF81965E618E0E3C7F960" amapKey:@""];
    
}

- (IBAction)login:(id)sender {
    [self push];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


- (void)push {
    AXBSDK *sdk = [[AXBSDK alloc] init];
    CustomViewController *vc = [[CustomViewController alloc] init];
    __weak CustomViewController *weakVC = vc;
    __weak ViewController *weakSelf = self;
    sdk.deviceListBlock = ^(UIViewController * deviceVC) {
        [weakVC setSDKDeviceView:deviceVC];
        [weakSelf.navigationController pushViewController:weakVC animated:YES];
    };
    [sdk loginWithUsername:@"yukari" pass:@"198611" controller:vc faild:^(NSString * msg, NSString * detail) {

    } successBlock:^{

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end