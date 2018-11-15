# 0CSdkDemo

## 1、初始化sdk

### 在要显示界面的控制器设置全局属性
    @property (nonatomic, retain)AXBSDK *sdk;
  
### 初始化sdk
    self.sdk = [[AXBSDK alloc] init];
    [self.sdk apiKeyWithKey:@"XXX" amapKey:@""];   

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
    
    实时定位信息 ["imei"(string), "isGps"(string), "laddress"(string), "location"(string), "steps"(string), "time".          (NSInteger)]
    self.sdk.deviceLocationBlock = ^(NSMutableDictionary *dic) {
        NSLog(@"get deivce location message ==== %@", dic);
    };
    
    绑定设备成功
    self.sdk.deviceBindSuccessBlock = ^ (NSMutableDictionary *dic){
        NSLog(@"deviceBindSuccessBlock - deviceinfo === %@", dic);
    };
    
    解绑设备成功
    self.sdk.deviceDeleteSuccessBlock = ^ (NSMutableDictionary *dic){
        NSLog(@"deviceDeleteSuccessBlock - deviceinfo === %@", dic);
    };

## 4、sdk APNS设置
    在appdelegate 设置获取apns token
    -(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    AXBSDK *sdk = [[AXBSDK alloc] init];
    [sdk getAppApnsTokenWithDeviceToken:<#(NSData * _Nonnull)#>]
    }

## 5、点击警报推送
    在appdelegate.m 添加
    
    - (void)setApnsMsg:(NSString *)msg {
    AXBSDK *sdk = [[AXBSDK alloc] init];
    [sdk getApnsMsgWithMsg:msg];
    }
    
    在函数调用
    - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSString *alertString = [userInfo valueForKey:@"extras"];
    if (alertString == nil || [alertString isEqual:[NSNull null]]) {
        NSDictionary *dic = [userInfo valueForKey:@"aps"];
        if (dic != nil && ![dic isEqual:[NSNull null]]) {
            NSString *newAlertString = [dic valueForKey:@"extras"];
            if (newAlertString == nil || [newAlertString isEqual:[NSNull null]]) {
                [self setApnsMsg:alertString];
            }
        }
    } else {
        [self setApnsMsg:alertString];
    }
    }
    
## 6、刷新设备
    [self.sdk refreshList];
## 7、退出登录
    [self.sdk loginOut];



