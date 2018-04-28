//
//  CustomViewController.m
//  HaierMedicApp
//
//  Created by 朱海铭 on 2018/4/21.
//  Copyright © 2018年 朱海铭. All rights reserved.
//

#import "CustomViewController.h"
#import <anXingBaoSDK/anXingBaoSDK-Swift.h>

@interface CustomViewController ()

@property (nonatomic, strong)UIView *customView;

@property (nonatomic)CGFloat height;

@property (nonatomic, retain)AXBSDK *sdk;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setsdk];
    [self login];
}

- (void)setsdk {
    self.sdk = [[AXBSDK alloc] init];
    [self.sdk apiKeyWithKey:@"6649E047900DF81965E618E0E3C7F960" amapKey:@""];
    __weak CustomViewController *weakSelf = self;
    // 超过一台的绑定设备
    self.sdk.deviceBindOverBlock = ^{
        [weakSelf hiddenNavigationBind];
    };
    // 可以绑定设备的回调
    self.sdk.deviceBindBlock = ^{
        [weakSelf setNavigationBind];
    };
    // token 过期
    self.sdk.tokenFaild = ^{
        
    };
    // 登录失败
    self.sdk.loginFaild = ^(NSString * msg, NSString * detailMsg) {
        NSLog(@"faile %@ \n %@", msg, detailMsg);
    };
    // 登录成功
    self.sdk.loginSuccess = ^{
        NSLog(@"success");
    };
    // 添加view
    self.sdk.deviceListBlock = ^(UIViewController * deviceVC) {
        [weakSelf setSDKDeviceView:deviceVC height:300];
    };
}

- (void)setNavigationBind {
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"绑定" style:UIBarButtonItemStylePlain target:self action:@selector(bindDevice)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)hiddenNavigationBind
{
    self.navigationItem.rightBarButtonItem = nil;
}

// 绑定设备
- (void)bindDevice {
    AXBSDK *sdk = [[AXBSDK alloc] init];
    [sdk bindDeviceWithController:self];
}

- (void)login {
    [self.sdk loginWithUsername:@"yukari" pass:@"198611" controller:self faild:^(NSString * msg, NSString * detail) {
    } successBlock:^{
        
    }];

}

- (UIView *)customView {
    if (_customView == nil) {
        CGFloat pointx = 0;
        CGFloat pointy = 70;
        CGFloat width = self.view.frame.size.width - 2 * pointx;
        CGFloat height = self.height;
        _customView = [[UIView alloc] initWithFrame:CGRectMake(pointx, pointy, width, height)];
        _customView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_customView];
    }
    return _customView;
}

- (void)setSDKDeviceView:(UIViewController *)deviceVC height:(CGFloat)height {
    self.height = height;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:deviceVC];
    deviceVC.view.tag = 10000; // 给其一个tag 方便寻找
    [self.customView addSubview:deviceVC.view];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    for (UIView *view in self.customView.subviews) {
        if (view.tag == 10000) {
            view.frame = self.customView.bounds;
            break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
