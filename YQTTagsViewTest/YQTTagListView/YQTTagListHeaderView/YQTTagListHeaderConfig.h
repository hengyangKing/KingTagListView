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
//是否隐藏button
@property(nonatomic,assign,readonly)BOOL hiddenButton;

#pragma mark set
///是否隐藏button
@property(nonatomic,copy,readonly)YQTTagListHeaderConfig *(^needHiddenButton)(BOOL hidden);

+(instancetype)defaultConfig;

@end
