//
//  MyImageView.h
//  NewMapApp
//
//  Created by jd on 17/2/24.
//  Copyright © 2017年 ZhuHaiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIImageView

@property (nonatomic, assign)CGFloat myCornerRadius;

@property (nonatomic, assign)BOOL myLayerMakeBounds;

@property (nonatomic, assign)CGFloat layerWidth;

@property (nonatomic, retain)UIColor *layerColor;

@property (nonatomic, assign)BOOL setLayerColor;

@end
