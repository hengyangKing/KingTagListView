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
    YQTTagListCustomButton *button = [self buttonWithType:(UIButtonTypeCustom)];
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
-(void (^)(NSString *))YQTTagListCustomButtonNormalTitle {
    return ^(NSString *title){
        self.config.normalTitle(title);
        [self setTitle:self.config.title forState:(UIControlStateNormal)];
    };
}
-(void (^)(NSString *))YQTTagListCustomButtonSelectTitle {
    return ^(NSString *title){
        self.config.selectTitle(title);
        [self setTitle:self.config.selectedTitle forState:(UIControlStateSelected)];
    };
}
-(void)setup {
    self.titleLabel.numberOfLines = 1;
    
    [self setBackgroundImage:self.config.normalBGImage forState:(UIControlStateNormal)];
    
    [self setBackgroundImage:self.config.disabledBGImage forState:(UIControlStateDisabled)];
    
    [self setBackgroundImage:self.config.selectedImage forState:(UIControlStateSelected)];
    
    [self setTitleColor:self.config.textColor forState:(UIControlStateNormal)];
    
    [self setTitleColor:self.config.selectedTextColor forState:(UIControlStateSelected)];
    
    
    [self setTitle:self.config.title forState:(UIControlStateNormal)];
    
    [self setTitle:self.config.selectedTitle forState:(UIControlStateSelected)];

    
    if (self.config.normalImage) {
        [self setImage:self.config.normalImage forState:(UIControlStateNormal)];
    }
    if (self.config.selectedImage) {
        [self setImage:self.config.selectedImage forState:(UIControlStateSelected)];
    }
    [self.titleLabel setFont:self.config.font];
    
    [self addTarget:self.config.target action:self.config.sel forControlEvents:(UIControlEventTouchUpInside)];
    
}
-(void)setHighlighted:(BOOL)highlighted {
    
}

@end
