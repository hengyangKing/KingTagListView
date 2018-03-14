//
//  YQTTagListBottomBarConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBarConfig.h"

@implementation YQTTagListBottomBarConfig
+(instancetype)defaultConfig {
    YQTTagListBottomBarConfig *config = [[YQTTagListBottomBarConfig alloc]init];

    config.bottomBarBackgroundColor([UIColor colorWithHex:@"#FFFFFF"]);
    config.costomInset(UIEdgeInsetsZero);
    return config;
}
-(YQTTagListBottomBarConfig *(^)(UIView *))bottomBarCostom {
    return ^(UIView *view){
        self.costom = view;
        return self;
    };
}
-(YQTTagListBottomBarConfig *(^)(UIEdgeInsets))costomInset {
    return ^(UIEdgeInsets insets){
        self.contentInset = insets;
        return self;
    };
}
-(YQTTagListBottomBarConfig *(^)(UIImage *))bottomBarShadow {
    return ^(UIImage *image){
        self.shadow = image;
        return self;
    };
}
-(YQTTagListBottomBarConfig *(^)(UIColor *))bottomBarBackgroundColor {
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}
-(void)setShadow:(UIImage *)shadow {
    _shadow = shadow;
}
-(void)setCostom:(UIView *)costom {
    _costom = costom;
}
-(void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
}
@end
