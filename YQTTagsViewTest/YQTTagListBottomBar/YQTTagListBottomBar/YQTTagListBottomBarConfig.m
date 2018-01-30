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
    config.bgColor = [UIColor colorWithHex:@"#FFFFFF"];
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



-(void)setCostom:(UIView *)costom {
    _costom = costom;
}
-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
}


@end
