//
//  YQTTagListBottomBarConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBarConfig.h"
#import "UIColor+YQKit.h"

@implementation YQTTagListBottomBarConfig
+(instancetype)defaultConfig {
    YQTTagListBottomBarConfig *config = [[YQTTagListBottomBarConfig alloc]init];
    
    config.bottomBarBGColor([UIColor colorWithHex:@"#FFFFFF"]).costomInset(UIEdgeInsetsZero).needCostomCornerRadius(YES);
    return config;
}




-(YQTTagListBottomBarConfig *(^)(UIView *))bottomBarCostom {
    return ^(UIView *view){
        self.costom = view;
        return self;
    };
}
-(YQTTagListBottomBarConfig *(^)(UIColor *))bottomBarBGColor {
    return ^(UIColor *color){
        self.bgColor = color;
        return self;
    };
}
-(YQTTagListBottomBarConfig *(^)(UIEdgeInsets))costomInset
{
    return ^(UIEdgeInsets insets){
        self.contentInset = insets;
        return self;
    };
}
-(YQTTagListBottomBarConfig *(^)(BOOL))needCostomCornerRadius {
    return ^(BOOL need){
        self.needCornerRadius = need;
        return self;
    };
}

-(void)setCostom:(UIView *)costom {
    _costom = costom;
}
-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
}

-(void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
}
-(void)setNeedCornerRadius:(BOOL)needCornerRadius
{
    _needCornerRadius = needCornerRadius;
}

@end
