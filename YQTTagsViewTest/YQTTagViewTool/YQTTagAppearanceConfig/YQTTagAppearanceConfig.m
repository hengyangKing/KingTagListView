//
//  YQTTagAppearanceConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/13.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagAppearanceConfig.h"
#import "UIImage+Stretchable.h"
#define YQTFONT(A) [UIFont fontWithName:@"PingFangSC-Regular"size:A]
#define YQKINGFONT(A) YQTFONT(A)?YQTFONT(A):[UIFont systemFontOfSize:A]
@interface YQTTagAppearanceConfig() {
    UIImage *_normalBGImage;
    UIImage *_selectedBGImage;
}
///bgColor
@property(nonatomic,strong)UIColor *bgColor;

///边框颜色
@property(nonatomic,strong)UIColor *borderColor;

///selectBGColor
@property(nonatomic,strong)UIColor *selectedBGColor;

///选中后边框颜色
@property(nonatomic,strong)UIColor *selectedBorderColor;
@end
@implementation YQTTagAppearanceConfig
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
-(void)setSelectedTitle:(NSString *)selectedTitle {
    _selectedTitle = selectedTitle;
}
-(void)setSelectedTextColor:(UIColor *)selectedTextColor {
    _selectedTextColor = selectedTextColor;
}

-(void)setFont:(UIFont *)font {
    _font = font;
}
-(UIImage *)normalBGImage {
    if (!_normalBGImage) {
        
        CGSize size = CGSizeMake(2, 2);
        if (self.cornerRadius) {
            size = CGSizeMake(self.cornerRadius*2+2, self.cornerRadius*2+2);
        }
        UIColor *bgColor = self.bgColor?self.bgColor:[UIColor clearColor];
        
        UIColor *borderColor = self.borderColor?self.borderColor:[UIColor clearColor];
        
        UIImage *image = [UIImage hyb_imageWithColor:bgColor toSize:size cornerRadius:self.cornerRadius backgroundColor:bgColor borderColor:borderColor borderWidth:self.borderWidth];
        _normalBGImage = image.stretchableImage;
    }
    return _normalBGImage;
}
-(UIImage *)selectedBGImage {
    if (!_selectedBGImage) {
        CGSize size = CGSizeMake(1, 1);
        if (self.cornerRadius) {
            size = CGSizeMake(self.cornerRadius*2, self.cornerRadius*2);
        }
        UIColor *bgColor = self.selectedBGColor?self.selectedBGColor:[UIColor clearColor];
        
        UIColor *borderColor = self.selectedBorderColor?self.selectedBorderColor:[UIColor clearColor];
        
        UIImage *image = [UIImage hyb_imageWithColor:bgColor toSize:size cornerRadius:self.cornerRadius backgroundColor:bgColor borderColor:borderColor borderWidth:self.borderWidth];
        
        _selectedBGImage = image.stretchableImage;
        
    }
    return _selectedBGImage;
}
#pragma mark get
-(YQTTagAppearanceConfig *(^)(NSString *))normalTitle {
    return ^(NSString *title){
        self.title = title;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(UIColor *))normalTitleColor {
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(UIColor *))normalBGColor {
    return ^(UIColor *color){
        self.bgColor = color;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(UIColor *))normalBorderColor {
    return ^(UIColor *color){
        self.borderColor = color;
        return self;
    };
}

-(YQTTagAppearanceConfig *(^)(NSString *))selectTitle {
    return ^(NSString *text){
        self.selectedTitle = text;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(UIColor *))selectTitleColor {
    return ^(UIColor *color){
        self.selectedTextColor = color;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(UIColor *))selectBGColor {
    return ^(UIColor *color){
        self.selectedBGColor = color;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(UIColor *))selectBorderColor {
    return ^(UIColor *color){
        self.selectedBorderColor = color;
        return self;
    };
}
-(YQTTagAppearanceConfig *(^)(CGFloat ))titleFont {
    return ^(CGFloat fontSize){
        self.font = YQKINGFONT(fontSize);
        return self;
    };
}
@end
