//
//  YQTTagListHeaderView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListHeaderView.h"
#import "YQTTagZoomButton.h"
#import "Masonry.h"

@interface YQTTagListHeaderView()
@property(nonatomic,strong)YQTTagListHeaderConfig *config;
@property(nonatomic,strong)YQTTagZoomButton *button;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,assign)TagListHeaderButtonState state;
@property(nonatomic,copy)void (^buttonClick)(TagListHeaderButtonState state);
@end
@implementation YQTTagListHeaderView

+(instancetype)TagListHeaderViewWith:(void (^)(YQTTagListHeaderConfig *config))config andButtonClick:(void (^)(TagListHeaderButtonState state))buttonClick {
    YQTTagListHeaderView *view = [[YQTTagListHeaderView alloc]init];
    [view setButtonClick:buttonClick];
    !config?:config(view.config);
    [view setup];
    return view;
}
-(void)setup {
    self.backgroundColor = [UIColor clearColor];
    [self setHidden:YES];
    [self addSubview:self.title];
    __weak typeof(self) weakself = self;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakself.mas_leading);
        make.top.bottom.mas_equalTo(weakself);
    }];
    
    if (!self.config.hiddenButton) {
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(weakself.mas_trailing);
            make.top.bottom.mas_equalTo(weakself);
            make.width.mas_equalTo(54.f);
        }];
    }
#pragma mark 默认状态 tag 全都选中 button title 为取消全选
    self.changeBtnState(ButtonStateIsSelectAll);
}
#pragma mark -- lazy
-(YQTTagListHeaderConfig *)config {
    if (!_config) {
        _config = [YQTTagListHeaderConfig defaultConfig];
    }
    return _config;
}
-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectZero];
        [_title setFont:self.config.font];
        [_title setTextColor:self.config.textColor];
    }
    return _title;
}
-(UIButton *)button {
    if (!_button) {
        
        __weak typeof(self) weakself = self;
        _button = [YQTTagZoomButton zoomButtonAnimateWidth:^CGFloat() {
            //动画
            return (weakself.state == ButtonStateIsSelectAll)?54.f:80.f;
            
        } andClickCompletion:^(BOOL nowSelect){
            
            //改变状态
            weakself.changeBtnState(nowSelect?ButtonStateIsSelectAll:ButtonStateIsUnSelectAll);
            //调用
            !weakself.buttonClick?:weakself.buttonClick(weakself.state);
        }];
        
        [_button.titleLabel setFont:self.config.btnFont];
        [_button setTitleColor:self.config.tinctColor forState:(UIControlStateNormal)];
        [_button setTitleColor:self.config.tinctColor forState:(UIControlStateSelected)];
        [_button setTitle:self.config.btnNormalTitle forState:(UIControlStateNormal)];
        [_button setTitle:self.config.btnSelectedTitle forState:(UIControlStateSelected)];
        if (self.config.borderW) {
            _button.layer.borderColor = self.config.tinctColor.CGColor;
            _button.layer.borderWidth = self.config.borderW;
        }
    }
    return _button;
}
-(void (^)(TagListHeaderButtonState))changeBtnState {
    return ^(TagListHeaderButtonState state){
        self.state = state;
    };
}
-(void (^)(NSString *))headerTitle {
    return ^(NSString *title){
        [self.title setText:title];
        [self setNeedsUpdateConstraints];
    };
}
-(void (^)(BOOL))hiddenHeaderButton {
    return ^(BOOL hidden){
        [self.button setHidden:hidden];
        self.config.needHiddenButton(hidden);
    };
}
-(void)setState:(TagListHeaderButtonState)state {
    _state = state;    
    self.button.selected = (_state == ButtonStateIsSelectAll)?NO:YES;
}



#pragma mark -- MAS
// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    
    if (self.title.text.length) {
        [self setHidden:NO];
        __weak typeof(self) weakself = self;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(TagListHeaderH);
            if (self.config.cornerRadius) {
                weakself.button.layer.cornerRadius = weakself.config.cornerRadius;
                weakself.button.layer.masksToBounds = YES;
            }
        }];
    }
    [super updateConstraints];
}
@end
