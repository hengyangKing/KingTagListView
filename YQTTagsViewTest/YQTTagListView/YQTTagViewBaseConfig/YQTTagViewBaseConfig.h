//
//  YQTTagViewBaseConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagListCommon.h"
@interface YQTTagViewBaseConfig : NSObject
#pragma mark get
///titleFont
@property(nonatomic,strong,readonly)UIFont *font;

///button圆角半径
@property(nonatomic,assign,readonly)CGFloat cornerRadius;
///titleColor
@property(nonatomic,strong,readonly)UIColor *textColor;
#pragma mark set

///font
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^titleFont)(UIFont * font);
///button圆角半径
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^radius)(CGFloat radius);
///titlecolor
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^titleColor)(UIColor *color);
@end
