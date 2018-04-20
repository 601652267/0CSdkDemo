//
//  DeviceLastMoneyTableViewCell.h
//  NewMapApp
//
//  Created by jd on 16/10/13.
//  Copyright © 2016年 ZhuHaiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiuLiangDataModel;

@interface DeviceLastMoneyTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHight:(CGFloat)cellHight;

- (void)setLastMessage:(LiuLiangDataModel *)model moneyKey:(NSString *)moneyKey dataKey:(NSString *)datakey messageKey:(NSString *)messageKey introductionKey:(NSString *)introductionKey remindDataKey:(NSString *)remindDataKey;

@end
