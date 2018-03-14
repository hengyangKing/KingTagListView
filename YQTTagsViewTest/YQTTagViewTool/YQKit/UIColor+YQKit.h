//
//  UIColor+YQKit.h
//  YIQIStudent
//
//  Created by kunyang on 15/12/5.
//  Copyright © 2015年 yangkun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YQKit)

+ (UIColor *)colorWithHexString:(NSString *)hexStr;
+ (UIColor*) colorWithHex:(NSString *)hexString; //以前工程用的方法，功能同上
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alphaValue;
+ (UIColor *)randomColor;
+ (NSString *)hexFromUIColor:(UIColor*) color;

@end
