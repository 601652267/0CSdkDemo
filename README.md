# 0CSdkDemo

## 1、初始化sdk
###在要显示界面的控制器设置全局属性
`@property (nonatomic, retain)AXBSDK *sdk;` 
  
###初始化sdk
`self.sdk = [[AXBSDK alloc] init];`  
`[self.sdk apiKeyWithKey:@"XXX" amapKey:@""];`  
## 2、初始化sdk
