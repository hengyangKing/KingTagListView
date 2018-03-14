//
//  YQTTagListHeaderConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagAppearanceConfig.h"

@interface YQTTagListHeaderConfig : YQTTagAppearanceConfig
#pragma mark get
//是否隐藏button
@property(nonatomic,assign,readonly)BOOL hiddenButton;


@property(nonatomic,strong,readonly)UIColor *headerTextColor;
#pragma mark set
///是否隐藏button
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^needHiddenButton)(BOOL hidden);

@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^HeaderTitleColor)(UIColor *color);

+(instancetype)defaultConfig;

@end
