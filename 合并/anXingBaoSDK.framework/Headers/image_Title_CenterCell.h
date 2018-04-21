//
//  image_Title_CenterCell.h
//  AnXingBaoApp
//
//  Created by jd on 16/9/6.
//  Copyright © 2016年 ZhuHaiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface image_Title_CenterCell : UITableViewCell

@property (nonatomic, retain)UIView *colorView;

- (void)setColor:(UIColor *)color;

+ (void)internationalVerSionSimpleChineseBlock:(void(^)(void))simpleChineseBlock englishBlock:(void(^)(void))englishBlock oldChineseBlock:(void(^)(void))oldChineseBlock;

@end
