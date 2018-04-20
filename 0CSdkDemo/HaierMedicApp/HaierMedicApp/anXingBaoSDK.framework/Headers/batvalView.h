//
//  batvalView.h
//  NewMapApp
//
//  Created by jd on 16/10/17.
//  Copyright © 2016年 ZhuHaiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface batvalView : UIView

@property (nonatomic, assign)BOOL isSelect;

@property (nonatomic, assign)CGFloat batvalPower;

- (void)setBatvalSelect:(BOOL)isSelect;

- (void)setPower:(int)power;

@end
