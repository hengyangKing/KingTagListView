//
//  YQTTagListCustomButton.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListCustomButton.h"
@interface YQTTagListCustomButton()
@property(nonatomic,strong)YQTButtonAppearanceConfig *config;

@end
@implementation YQTTagListCustomButton

+(instancetype)createCustomButtonWithConfig:(void (^)(YQTButtonAppearanceConfig *))config {
    YQTTagListCustomButton *button = [YQTTagListCustomButton buttonWithType:(UIButtonTypeCustom)];
    !config? : config(button.config);
    [button setup];
    return button;
}
-(YQTButtonAppearanceConfig *)config {
    if (!_config) {
        _config = [YQTButtonAppearanceConfig defaultConfig];
    }
    return _config;
}
-(void)setup {
    
    [self setBackgroundImage:self.config.normalBGImage forState:(UIControlStateNormal)];
    
    [self setBackgroundImage:self.config.normalBGImage forState:(UIControlStateHighlighted)];
    
    [self setBackgroundImage:self.config.disabledBGImage forState:(UIControlStateDisabled)];
    
    [self setTitleColor:self.config.textColor forState:(UIControlStateNormal)];
    
    [self setTitle:self.config.title forState:(UIControlStateNormal)];
    
    if (self.config.normalImage) {
        [self setImage:self.config.normalImage forState:(UIControlStateNormal)];
    }
    if (self.config.selectedImage) {
        [self setImage:self.config.selectedImage forState:(UIControlStateSelected)];
    }
    [self.titleLabel setFont:self.config.font];
    
    [self addTarget:self.config.target action:self.config.sel forControlEvents:(UIControlEventTouchUpInside)];
    
}
@end
