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
    config.titleFont(YQTFONT(14)).radius(6.f).titleColor([UIColor colorWithHex:@"F333333"]);
    //
    config.buttonFont(YQTFONT(12)).borderWidth(1.f).tintColor([UIColor colorWithHex:@"#15A6EE"]).needHiddenButton(NO).normalTitle(@"全选").selectedTitle(@"取消全选");
    return config;
}
#pragma mark set

-(void)setBtnNormalTitle:(NSString *)btnNormalTitle {
    _btnNormalTitle = btnNormalTitle;
}
-(void)setBtnSelectedTitle:(NSString *)btnSelectedTitle {
    _btnSelectedTitle = btnSelectedTitle;
}
-(void)setBorderW:(CGFloat)borderW {
    _borderW = borderW;
}
-(void)setTinctColor:(UIColor *)tinctColor {
    _tinctColor = tinctColor;
}
-(void)setHiddenButton:(BOOL)hiddenButton {
    _hiddenButton = hiddenButton;
}
-(void)setBtnFont:(UIFont *)btnFont {
    _btnFont = btnFont;
}

#pragma mark get

-(YQTTagListHeaderConfig *(^)(NSString *))normalTitle
{
    return ^(NSString *title){
        self.btnNormalTitle = title;
        return self;
    };
}
-(YQTTagListHeaderConfig *(^)(NSString *))selectedTitle {
    return ^(NSString *title){
        self.btnSelectedTitle = title;
        return self;
    };
}
-(YQTTagListHeaderConfig *(^)(CGFloat))borderWidth {
    return ^(CGFloat width){
        self.borderW = width;
        return self;
    };
}
-(YQTTagListHeaderConfig *(^)(UIColor *))tintColor
{
    return ^(UIColor *color){
        self.tinctColor = color;
        return self;
    };
}

-(YQTTagListHeaderConfig *(^)(BOOL))needHiddenButton {
    return ^(BOOL hidden){
        self.hiddenButton = hidden;
        return self;
    };
}
-(YQTTagListHeaderConfig *(^)(UIFont *))buttonFont {
    return ^(UIFont *font){
        self.btnFont = font;
        return self;
    };
}


@end
