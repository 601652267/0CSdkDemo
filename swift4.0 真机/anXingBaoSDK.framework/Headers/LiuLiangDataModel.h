//
//  LiuLiangDataModel.h
//  NewMapApp
//
//  Created by jd on 16/12/26.
//  Copyright © 2016年 ZhuHaiMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiuLiangDataModel : NSObject<NSCoding>

@property (nonatomic, retain)NSString *simFreeData;

@property (nonatomic, retain)NSString *simFreeVoice;

@property (nonatomic, retain)NSString *simFreeSMS;

@property (nonatomic, retain)NSString *voiceUsage;

@property (nonatomic, retain)NSString *dataUsage;

@property (nonatomic, retain)NSString *balance;

@end
