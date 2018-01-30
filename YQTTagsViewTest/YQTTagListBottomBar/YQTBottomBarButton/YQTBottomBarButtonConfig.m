//
//  YQTBottomBarButtonConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTBottomBarButtonConfig.h"
#import "UIColor+YQKit.h"
#import "YQTTagListCommon.h"
@implementation YQTBottomBarButtonConfig
+(instancetype)defaultConfig {
    
    YQTBottomBarButtonConfig *config = [[YQTBottomBarButtonConfig alloc]init];
    config.YQTButtonTitleColor([UIColor colorWithHex:@"#FFFFFF"]).YQTButtonBGColor([UIColor colorWithHex:@"#15A6EE"]).YQTButtonShowBorder(NO).YQTButtonBorderWidth(1).YQTButtonBorderColor([UIColor colorWithHex:@"#15A6EE"]).YQTButtonBorderCornerRadius(50.f).YQTButtonTitleFont(YQTFONT(18));
    
    return config;
}

//set
-(void)setTarget:(id)target {
    _target = target;
}
-(void)setSel:(SEL)sel {
    _sel = sel;
}
-(void)setTitle:(NSString *)title {
    _title = [title copy];
}
-(void)setImage:(UIImage *)image {
    _image = image;
}
-(void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
}
-(void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
}
-(void)setShowBorder:(BOOL)showBorder {
    _showBorder = showBorder;
}
-(void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
}
-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
}
-(void)setFont:(UIFont *)font {
    _font = font;
}

//get
-(YQTBottomBarButtonConfig *(^)(id))YQTButtonTarget {
    return ^(id target){
        self.target = target;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(SEL))YQTButtonSEL {
    return ^(SEL sel){
        self.sel = sel;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(NSString *))YQTButtonTitle {
    return ^(NSString *title){
        self.title=title;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(UIColor *))YQTButtonBGColor{
    return ^(UIColor *color){
        self.bgColor = color;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(NSString *))YQTButtonImage
{
    return ^(NSString *name){
        self.image = [UIImage imageNamed:name];
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(UIColor *))YQTButtonTitleColor {
    return ^(UIColor *color){
        self.titleColor = color;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(BOOL))YQTButtonShowBorder {
    return ^(BOOL show){
        self.showBorder = show;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(CGFloat))YQTButtonBorderWidth {
    return ^(CGFloat width){
        self.borderWidth = width;
        return self;
    };
}
-(YQTBottomBarButtonConfig *(^)(UIColor *))YQTButtonBorderColor {
    return ^(UIColor *color){
        self.borderColor = color;
        return self;
    };
}

-(YQTBottomBarButtonConfig *(^)(CGFloat))YQTButtonBorderCornerRadius {
    return ^(CGFloat radius){
        self.cornerRadius = radius;
        return self;
    };
}

-(YQTBottomBarButtonConfig *(^)(UIFont *))YQTButtonTitleFont {
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

@end
