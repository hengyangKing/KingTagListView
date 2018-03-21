//
//  YQTTagListHeaderConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListHeaderConfig.h"

@implementation YQTTagListHeaderConfig
+(instancetype)defaultConfig {
    YQTTagListHeaderConfig *config = [[YQTTagListHeaderConfig alloc]init];
    
    //基类
    config.radius(6.f).borderW(1.f);
    
    config.titleFont(14);
    config.normalTitleColor([UIColor colorWithHex:@"#15A6EE"]).selectTitleColor([UIColor colorWithHex:@"#15A6EE"]);
    config.normalBorderColor([UIColor colorWithHex:@"#15A6EE"]).normalBGColor([UIColor colorWithHex:@"F333333"]);
    
    config.selectBGColor([UIColor colorWithHex:@"F333333"]).selectBorderColor([UIColor colorWithHex:@"#15A6EE"]);
    
    config.normalTitle(@"全选").selectTitle(@"取消全选");
    
    config.needHiddenButton(NO).HeaderTitleColor([UIColor blackColor]);
    return config;
}

#pragma mark set
-(void)setHiddenButton:(BOOL)hiddenButton {
    _hiddenButton = hiddenButton;
}
-(void)setHeaderTextColor:(UIColor *)headerTextColor {
    _headerTextColor = headerTextColor;
}
#pragma mark get
-(YQTTagListHeaderConfig *(^)(BOOL))needHiddenButton {
    return ^(BOOL hidden){
        self.hiddenButton = hidden;
        return self;
    };
}
-(YQTTagListHeaderConfig *(^)(UIColor *))HeaderTitleColor {
    return ^(UIColor *color){
        self.headerTextColor  = color;
        return self;
    };
}
@end
