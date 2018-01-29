//
//  YQTTagViewBaseConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagViewBaseConfig.h"

@implementation YQTTagViewBaseConfig
#pragma mark set
-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
}
-(void)setFont:(UIFont *)font {
    _font = font;
}
-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}


#pragma mark get
-(YQTTagViewBaseConfig *(^)(CGFloat))radius {
    return ^(CGFloat radius){
        self.cornerRadius = radius;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIFont *))titleFont {
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}
-(YQTTagViewBaseConfig *(^)(UIColor *))titleColor {
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
@end
