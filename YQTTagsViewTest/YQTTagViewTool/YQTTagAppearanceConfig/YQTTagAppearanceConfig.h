//
//  YQTTagAppearanceConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/3/13.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListAppearanceConfig.h"

@interface YQTTagAppearanceConfig : YQTTagListAppearanceConfig
#pragma mark get
///  normal
///title
@property(nonatomic,copy,readonly)NSString *title;

///titleColor
@property(nonatomic,strong,readonly)UIColor *textColor;

///bgImage
@property(nonatomic,strong,readonly)UIImage *normalBGImage;


/// select

///select title
@property(nonatomic,copy,readonly)NSString *selectedTitle;

///selectTitleColor
@property(nonatomic,strong,readonly)UIColor *selectedTextColor;


@property(nonatomic,strong,readonly)UIImage *selectedBGImage;


///const
///titleFont
@property(nonatomic,strong,readonly)UIFont *font;

#pragma mark set

///normal
@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^normalTitle)(NSString *title);

@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^normalTitleColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^normalBGColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^normalBorderColor)(UIColor *color);


///selected
@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^selectTitle)(NSString *title);

@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^selectTitleColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^selectBGColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^selectBorderColor)(UIColor *color);


///const
///font
@property(nonatomic,copy,readonly)YQTTagAppearanceConfig *(^titleFont)(UIFont * font);


@end
