//
//  YQTRectangleTagConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTRectangleTagConfig.h"

@implementation YQTRectangleTagConfig
+(instancetype)defaultConfig {
    YQTRectangleTagConfig *config = [[YQTRectangleTagConfig alloc]init];
    return config;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.rectTagTintColor([UIColor colorWithHex:@"#3EA7DB"]).rectTagSelectTintColor([UIColor colorWithHex:@"#90969E"]).rectTagBorderW(1.f);
    }
    return self;
}
#pragma mark
-(void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
}

-(void)setSelectTintColor:(UIColor *)selectTintColor {
    _selectTintColor = selectTintColor;
}
-(void)setBorderW:(CGFloat)borderW {
    _borderW = borderW;
}

#pragma mark get
-(YQTRectangleTagConfig *(^)(UIColor *))rectTagTintColor {
    return ^(UIColor *color){
        self.tintColor = color;
        return self;
    };
}

-(YQTRectangleTagConfig *(^)(UIColor *))rectTagSelectTintColor {
    return ^(UIColor *color){
         self.selectTintColor = color;
        return self;
    };
}

-(YQTRectangleTagConfig *(^)(CGFloat))rectTagBorderW {
    return ^(CGFloat w){
        self.borderW = w;
        return self;
    };
}
@end
