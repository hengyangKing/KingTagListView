//
//  YQTTagViewBaseConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagViewBaseConfig.h"

@implementation YQTTagViewBaseConfig
-(instancetype)init{
    self = [super init];
    if (self) {
        self.normalBorderColor([UIColor clearColor]);
        self.selectBorderColor([UIColor clearColor]);
    }
    return self;
}
#pragma mark set
-(void)setTitle:(NSString *)title {
    _title = title;
}
-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}
-(void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
}
-(void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
}
-(void)setSelectedTitle:(NSString *)selectedTitle {
    _selectedTitle = selectedTitle;
}
-(void)setSelectedTextColor:(UIColor *)selectedTextColor {
    _selectedTextColor = selectedTextColor;
}
-(void)setSelectedBGColor:(UIColor *)selectedBGColor {
    _selectedBGColor = selectedBGColor;
}
-(void)setSelectedBorderColor:(UIColor *)selectedBorderColor {
    _selectedBorderColor = selectedBorderColor;
}




-(void)setFont:(UIFont *)font {
    _font = font;
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
}
-(void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
}

#pragma mark get
-(YQTTagViewBaseConfig *(^)(NSString *))normalTitle {
    return ^(NSString *title){
        self.title = title;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))normalTitleColor {
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))normalBGColor {
    return ^(UIColor *color){
        self.bgColor = color;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))normalBorderColor {
    return ^(UIColor *color){
        self.borderColor = color;
        return self;
    };
}

-(YQTTagViewBaseConfig *(^)(NSString *))selectTitle {
    return ^(NSString *text){
        self.selectedTitle = text;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))selectTitleColor {
    return ^(UIColor *color){
        self.selectedTextColor = color;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))selectBGColor {
    return ^(UIColor *color){
        self.selectedBGColor = color;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))selectBorderColor {
    return ^(UIColor *color){
        self.selectedBorderColor = color;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIFont *))titleFont {
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(CGFloat))radius {
    return ^(CGFloat cornerRadius){
        self.cornerRadius = cornerRadius;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(CGFloat))borderW {
    return ^(CGFloat width){
        self.borderWidth = width;
        return self;
    };
}



@end
