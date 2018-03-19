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
        ///normal
        self.normalTitleColor(Color(@"#333333"));
        self.normalBGColor(Color(@"#FFFFFF"));
        
        ///select
        self.selectTitleColor(Color(@"#BBBBBB"));
        self.selectBGColor(Color(@"#EDEDED"));
        
        ///const
        self.titleFont(15);
        self.radius(6.f);
        self.borderW(.5f);
        
        //子类
        self.delineColor(Color(@"#BBBBBB"));
        self.contentViewInset(UIEdgeInsetsMake(0,0,0,0));
        self.isSelect(NO);
    }
    return self;
}


#pragma mark set
-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}
-(void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
}
-(void)setSelect:(BOOL)select {
    _select = select;
}

#pragma mark get

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


@end
