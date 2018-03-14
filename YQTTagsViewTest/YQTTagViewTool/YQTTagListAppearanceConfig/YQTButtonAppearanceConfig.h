//
//  YQTButtonAppearanceConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagAppearanceConfig.h"

@interface YQTButtonAppearanceConfig : YQTTagAppearanceConfig
+(instancetype)defaultConfig;
//行为
@property(nonatomic,strong,readonly)id target;
@property(nonatomic,assign,readonly)SEL sel;
//外观
@property(nonatomic,strong,readonly)UIImage *normalImage;

@property(nonatomic,strong,readonly)UIImage *selectedImage;


@property(nonatomic,strong,readonly)UIImage *disabledBGImage;


@property(nonatomic,copy,readonly)YQTButtonAppearanceConfig *(^YQTButtonTarget)(id target);
@property(nonatomic,copy,readonly)YQTButtonAppearanceConfig *(^YQTButtonSEL)(SEL sel);

@property(nonatomic,copy,readonly)YQTButtonAppearanceConfig *(^YQTButtonNormalImage)(NSString *name);


@property(nonatomic,copy,readonly)YQTButtonAppearanceConfig *(^YQTButtonSelectedImage)(NSString *name);


@property(nonatomic,copy,readonly)YQTButtonAppearanceConfig *(^YQTButtonDisabledBorderColor)(UIColor *color);
@end
