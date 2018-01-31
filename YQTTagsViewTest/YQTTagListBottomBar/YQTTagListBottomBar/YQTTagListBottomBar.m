//
//  YQTTagListBottomBar.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBar.h"
#import "YQTTagListCommon.h"
#import "YQTTagListBottomBarShadowView.h"



#define BOTTOMBARH (MARGINH>0?(78+MARGINH):78)//Bar高

#define MARGINH ([[UIApplication sharedApplication] statusBarFrame].size.height>20? 34:0)


@interface YQTTagListBottomBar()
@property(nonatomic,strong)YQTTagListBottomBarConfig *config;
@property(nonatomic,strong)UIView *margin;
@property(nonatomic,strong)YQTTagListBottomBarShadowView *shadowView;

@property(nonatomic,assign)BOOL isShow;

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
-(YQTTagListBottomBarShadowView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[YQTTagListBottomBarShadowView alloc]initWithImage:self.config.shadow];
    }
    return _shadowView;
}
#pragma mark -- func
-(void)setup {
    if (self.config.shadow) {
        [self addSubview:self.shadowView];
    }
    [self addSubview:self.margin];
    self.margin.backgroundColor = self.config.bgColor;
    self.backgroundColor = self.config.bgColor;
    [self addSubview:self.config.costom];
    [self.config.costom hyb_addCornerRadius:50.f];
    [self setNeedsUpdateConstraints];
}
-(void)didMoveToSuperview {

    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.superview);
        make.top.mas_equalTo(self.superview.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(BOTTOMBARH);
    }];
}
#pragma mark -- MAS
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
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
    [super updateConstraints];
}
#pragma mark -- get
-(CGFloat)barH {
    return BOTTOMBARH;
}
#pragma mark -- set
-(void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    //动画执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.superview.mas_bottom).mas_offset(_isShow ? -BOTTOMBARH: 0);
        }];
        [self.superview setNeedsUpdateConstraints];
        [self.superview updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:.3f animations:^{
            [self.superview layoutIfNeeded];
        } completion:nil];
    });
}

#pragma mark -- func
-(void)dismiss {
    self.isShow = NO;
}

-(void)show {
    self.isShow = YES;;
}

@end
