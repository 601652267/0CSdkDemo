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

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationStyle];
}

- (void)setNavigationStyle {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = left;
}

- (void)back {
    AXBSDK *sdk = [[AXBSDK alloc] init];
    [sdk loginOut];
    [self.navigationController popViewControllerAnimated:true];
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
