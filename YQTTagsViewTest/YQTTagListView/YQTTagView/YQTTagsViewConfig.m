//
//  YQTTagsViewConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagsViewConfig.h"

@implementation YQTTagsViewConfig
+(instancetype)defaultConfig {
    YQTTagsViewConfig *config = [[YQTTagsViewConfig alloc]init];
    return config;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        //基类
        self.titleFont([UIFont fontWithName:@"PingFangSC-Regular"size:15]).radius(3.f).titleColor([UIColor colorWithHex:@"#333333"]);
        //子类
        self.normalBGColor([UIColor colorWithHex:@"#FFFFFF"]).selectedBGColor([UIColor colorWithHex:@"#EDEDED"]).delineColor([UIColor colorWithHex:@"#BBBBBB"]).contentViewInset(UIEdgeInsetsMake(0,0,0,0)).isSelect(NO).selectedTitleTextColor([UIColor colorWithHex:@"#BBBBBB"]);
    }
    return self;
}


#pragma mark set
-(void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
}
-(void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
}

-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}
-(void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
}
-(void)setSelect:(BOOL)select {
    _select = select;
}
-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
}
-(void)setText:(NSString *)text {
    _text = text;
}
#pragma mark get
-(YQTTagsViewConfig *(^)(UIColor *))normalBGColor {
    return ^(UIColor *color){
        self.normalColor = color;
        return self;
    };
}
-(YQTTagsViewConfig *(^)(UIColor *))selectedBGColor {
    return ^(UIColor *color){
        self.selectedColor = color;
        return self;
    };
}
-(YQTTagsViewConfig *(^)(UIColor *))delineColor {
    return ^(UIColor *color){
        self.lineColor = color;
        return self;
    };
}
-(YQTTagsViewConfig *(^)(UIEdgeInsets))contentViewInset {
    return ^(UIEdgeInsets insets){
        self.contentInset = insets;
        return self;
    };
}

-(YQTTagsViewConfig *(^)(BOOL))isSelect {
    return ^(BOOL selelct){
        self.select = selelct;
        return self;
    };
}
-(YQTTagsViewConfig *(^)(UIColor *))selectedTitleTextColor{
    return ^(UIColor *color){
        self.selectedTitleColor = color;
        return self;
    };
}
-(YQTTagsViewConfig *(^)(NSString *))titleText {
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

@end
