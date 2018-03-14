//
//  YQTTagListBottomBarConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagAppearanceConfig.h"

@interface YQTTagListBottomBarConfig : YQTTagAppearanceConfig
+(instancetype)defaultConfig;

@property(nonatomic,strong,readonly)UIView *costom;

@property(nonatomic,assign,readonly)UIEdgeInsets contentInset;

@property(nonatomic,strong,readonly)UIImage *shadow;

@property(nonatomic,strong,readonly)UIColor *backgroundColor;


@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarBackgroundColor)(UIColor *);

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarCostom)(UIView *);

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarShadow)(UIImage *);


@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^costomInset)(UIEdgeInsets contentInset);


@end
