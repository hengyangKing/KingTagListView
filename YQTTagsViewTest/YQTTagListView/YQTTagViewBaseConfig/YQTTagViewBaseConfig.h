//
//  YQTTagViewBaseConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagListCommon.h"
#import "UIColor+YQKit.h"
@interface YQTTagViewBaseConfig : NSObject
#pragma mark get
///  normal

///title
@property(nonatomic,copy,readonly)NSString *title;

///titleColor
@property(nonatomic,strong,readonly)UIColor *textColor;

///bgColor
@property(nonatomic,strong,readonly)UIColor *bgColor;

///边框颜色
@property(nonatomic,strong,readonly)UIColor *borderColor;



/// select

///select title
@property(nonatomic,copy,readonly)NSString *selectedTitle;

///selectTitleColor
@property(nonatomic,strong,readonly)UIColor *selectedTextColor;

///selectBGColor
@property(nonatomic,strong,readonly)UIColor *selectedBGColor;

///选中后边框颜色
@property(nonatomic,strong,readonly)UIColor *selectedBorderColor;





///const
///titleFont
@property(nonatomic,strong,readonly)UIFont *font;

///button圆角半径
@property(nonatomic,assign,readonly)CGFloat cornerRadius;

///边框宽度
@property(nonatomic,assign,readonly)CGFloat borderWidth;


#pragma mark set

///normal
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^normalTitle)(NSString *title);

@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^normalTitleColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^normalBGColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^normalBorderColor)(UIColor *color);


///selected
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^selectTitle)(NSString *title);

@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^selectTitleColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^selectBGColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^selectBorderColor)(UIColor *color);


///const

///font
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^titleFont)(UIFont * font);
///圆角半径
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^radius)(CGFloat radius);
///边框宽度
@property(nonatomic,copy,readonly)YQTTagViewBaseConfig *(^borderW)(CGFloat width);
@end
