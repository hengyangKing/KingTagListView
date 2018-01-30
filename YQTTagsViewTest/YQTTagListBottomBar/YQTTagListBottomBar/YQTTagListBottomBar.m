//
//  YQTTagListBottomBar.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBar.h"
#import "YQTTagListCommon.h"

#define BOTTOMBARH (MARGINH>0?(78+MARGINH):78)//Bar高

#define MARGINH ([[UIApplication sharedApplication] statusBarFrame].size.height>20? 34:0)


@interface YQTTagListBottomBar()
@property(nonatomic,strong)YQTTagListBottomBarConfig *config;
@property(nonatomic,strong)UIView *margin;
@end
@implementation YQTTagListBottomBar

+(instancetype)createBottomBarWithConfig:(void (^)(YQTTagListBottomBarConfig *))config {
    YQTTagListBottomBar *bar = [[YQTTagListBottomBar alloc]init];
    !config? : config(bar.config);
    [bar setup];
    return bar;

}
#pragma mark -- lazy
-(YQTTagListBottomBarConfig *)config{
    if (!_config) {
        _config = [YQTTagListBottomBarConfig defaultConfig];
    }
    return _config;
}
-(UIView *)margin {
    if (!_margin) {
        _margin = [[UIView alloc]init];
        _margin .backgroundColor = [UIColor yellowColor];
    }
    return _margin;
}
#pragma mark -- func
-(void)setup {
    [self addSubview:self.margin];
    self.margin.backgroundColor = self.config.bgColor;
    self.backgroundColor = self.config.bgColor;
    [self addSubview:self.config.costom];
    
    [self setNeedsUpdateConstraints];
}
-(void)didMoveToSuperview {

    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.superview);
        make.height.mas_equalTo(BOTTOMBARH);
    }];
}
#pragma mark -- MAS
// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    
    __weak typeof(self) weakself = self;
    [self.margin mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(weakself);
        make.height.mas_equalTo(MARGINH);
    }];
    UIEdgeInsets insets = self.config.contentInset;
    [self.config.costom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakself).mas_offset(insets.left);
        make.top.mas_equalTo(weakself).mas_offset(insets.top);
        make.trailing.mas_equalTo(weakself).mas_offset(-insets.right);
        make.bottom.mas_equalTo(weakself.margin.mas_top).mas_offset(-insets.bottom);
    }];
    if (self.config.needCornerRadius) {
        CGFloat H = BOTTOMBARH - MARGINH - insets.top - insets.bottom;
        self.config.costom.layer.cornerRadius =H/2.0f;
        self.config.costom.layer.masksToBounds = YES;
    }
    [super updateConstraints];
}



@end
