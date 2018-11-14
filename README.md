# 0CSdkDemo

## 1、初始化sdk
### 在要显示界面的控制器设置全局属性
`@property (nonatomic, retain)AXBSDK *sdk;` 
  
### 初始化sdk
`self.sdk = [[AXBSDK alloc] init];`  
`[self.sdk apiKeyWithKey:@"XXX" amapKey:@""];`    

## 2、添加安行宝控制器到自己的界面
### 控制器内添加界面的函数
- (void)setSDKDeviceView:(UIViewController *)deviceVC height:(CGFloat)height {  
    self.height = height;  
    self.view.backgroundColor = [UIColor whiteColor];  
    [self addChildViewController:deviceVC];  
    deviceVC.view.tag = 10000; // 给其一个tag 方便寻找  
    [self.customView addSubview:deviceVC.view];  
}
