//
//  YQTTagListHeaderConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagViewBaseConfig.h"

@interface YQTTagListHeaderConfig : YQTTagViewBaseConfig
#pragma mark get
///button normalTitle
@property(nonatomic,copy,readonly)NSString *btnNormalTitle;
///button selectedTitle
@property(nonatomic,copy,readonly)NSString *btnSelectedTitle;
///边框宽度
@property(nonatomic,assign,readonly)CGFloat borderW;
//风格颜色
@property(nonatomic,strong,readonly)UIColor *tinctColor;

//是否隐藏button
@property(nonatomic,assign,readonly)BOOL hiddenButton;

@property(nonatomic,strong,readonly)UIFont *btnFont;

#pragma mark set
///button NormalTitle
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^normalTitle)(NSString *title);
///button selectedTitle
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^selectedTitle)(NSString *title);
/// borderW
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^borderWidth)(CGFloat width);

///tintColor
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^tintColor)(UIColor *color);

///是否隐藏button
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^needHiddenButton)(BOOL hidden);

@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^buttonFont)(UIFont *font);

+(instancetype)defaultConfig;



@end
