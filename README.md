# 0CSdkDemo

## 1、初始化sdk

### 在要显示界面的控制器设置全局属性
`@property (nonatomic, retain)AXBSDK *sdk;` 
  
### 初始化sdk
`self.sdk = [[AXBSDK alloc] init];`  
`[self.sdk apiKeyWithKey:@"XXX" amapKey:@""];`    

## 2、添加安行宝控制器到自己的界面

### 控制器内添加界面的api
    -(void)setSDKDeviceView:(UIViewController *)deviceVC height:(CGFloat)height {  
    self.height = height;  
    self.view.backgroundColor = [UIColor whiteColor];  
    [self addChildViewController:deviceVC];  
    deviceVC.view.tag = 10000; // 给其一个tag 方便寻找  
    [self.customView addSubview:deviceVC.view];  
    }
    
### 在sdk的控制器回调里面使用该api
    __weak xxxController *weakSelf = self;
    添加view
    self.sdk.deviceListBlock = ^(UIViewController * deviceVC) {
        [weakSelf setSDKDeviceView:deviceVC height:320];
    };
    
## 3、sdk其他回调

### 1、超过一台的绑定设备
    __weak xxxController *weakSelf = self;
    self.sdk.deviceBindOverBlock = ^{
        [weakSelf hiddenNavigationBind];
    };
    隐藏添加设备的按钮 
    -(void)hiddenNavigationBind
    {}
    
### 2、可以绑定设备的回调
    __weak xxxController *weakSelf = self;
    self.sdk.deviceBindBlock = ^{
        [weakSelf setNavigationBind];
    };
    展示可以点击绑定设备的按钮
    -(void)setNavigationBind {}
    
    绑定设备
    -(void)bindDevice {
    self.sdk = [[AXBSDK alloc] init];
    [self.sdk bindDeviceWithController:self];
    }
    
### 3、其他回调
    oken 过期
    self.sdk.tokenFaild = ^{
        
    };
    登录失败
    self.sdk.loginFaild = ^(NSString * msg, NSString * detailMsg) {
        NSLog(@"faile %@ \n %@", msg, detailMsg);
    };
    登录成功
    self.sdk.loginSuccess = ^{
        NSLog(@"success");
    };
    
    self.sdk.deviceLocationBlock = ^(NSMutableDictionary *dic) {
        // 实时定位信息 ["imei"(string), "isGps"(string), "laddress"(string), "location"(string), "steps"(string), "time".          (NSInteger)]
        NSLog(@"get deivce location message ==== %@", dic);
    };

## 4、sdk APNS设置
    在appdelegate 设置获取apns token
    -(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    AXBSDK *sdk = [[AXBSDK alloc] init];
    [sdk getAppApnsTokenWithDeviceToken:<#(NSData * _Nonnull)#>]
    }





