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
    config.titleFont(YQTFONT(14)).radius(6.f).normalTitleColor([UIColor colorWithHex:@"#15A6EE"]).selectTitleColor([UIColor colorWithHex:@"#15A6EE"]).borderW(1.f).normalBorderColor([UIColor colorWithHex:@"#15A6EE"]).normalBGColor([UIColor colorWithHex:@"F333333"]).selectBGColor([UIColor colorWithHex:@"F333333"]).normalTitle(@"全选").selectTitle(@"取消全选");
    
    config.needHiddenButton(NO);
    return config;
}

#pragma mark set
-(void)setHiddenButton:(BOOL)hiddenButton {
    _hiddenButton = hiddenButton;
}
#pragma mark get
-(YQTTagListHeaderConfig *(^)(BOOL))needHiddenButton {
    return ^(BOOL hidden){
        self.hiddenButton = hidden;
        return self;
    };
}
@end
