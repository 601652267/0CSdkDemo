//
//  OCObject.h
//  NewAnXingBaoProject
//
//  Created by 朱海铭 on 2017/9/4.
//  Copyright © 2017年 朱海铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface OCObject : NSObject

+ (NSData *)setImageDataWithImage:(UIImage *)userImage;

+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

+ (void)startPay:(NSDictionary *)pay;

+ (BOOL)isIMEI:(NSString *)string;

+ (NSString*)weekdayStringFromDate:(NSDate *)inputDate;

+ (NSMutableDictionary *)getUrlDicWithUrl:(NSString *)url;

+ (NSString *)iphoneType;

+ (NSString *)deviceVersion;

+ (NSString *)deviceLocation;

+ (NSString *)URLDecodedString:(NSString *)str;

+ (NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

+ (void)saveUUID:(NSString *)uuid;

+ (NSString *)readUUID;

+ (void)deleteUUID;

+ (void)setUpUUID;

+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

+ (NSAttributedString *)getAttributedString:(NSString *)str;

+ (BOOL)isEamil:(NSString *)eamil;
    //是否是纯数字
+ (BOOL)isNumText:(NSString *)str;

+ (UIImage *)getIconImage:(UIView *)view size:(CGSize)size;

+ (UIImage*)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
