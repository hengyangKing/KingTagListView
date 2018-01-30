//
//  YQTBottomBarButton.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTBottomBarButton.h"
#import "UIColor+Image.h"
@interface YQTBottomBarButton()
@property(nonatomic,strong)YQTBottomBarButtonConfig *config;

@end
@implementation YQTBottomBarButton
+(instancetype)createBottomBarButtonWithConfig:(void (^)(YQTBottomBarButtonConfig *))config {
    YQTBottomBarButton *button = [YQTBottomBarButton buttonWithType:(UIButtonTypeCustom)];
    !config? : config(button.config);
    [button setup];
    return button;
}
-(YQTBottomBarButtonConfig *)config
{
    if (!_config) {
        _config = [YQTBottomBarButtonConfig defaultConfig];
    }
    return _config;
}
-(void)setup {

    [self setBackgroundImage:self.config.bgColor.image forState:(UIControlStateNormal)];
    [self setTitleColor:self.config.titleColor forState:(UIControlStateNormal)];
    [self setTitle:self.config.title forState:(UIControlStateNormal)];
    [self setImage:self.config.image forState:(UIControlStateNormal)];
    [self.titleLabel setFont:self.config.font];
    [self addTarget:self.config.target action:self.config.sel forControlEvents:(UIControlEventTouchUpInside)];
    
    if (self.config.isShowBorder) {
        self.layer.borderWidth = self.config.borderWidth;
        self.layer.borderColor = self.config.borderColor.CGColor;
    }
}

@end
