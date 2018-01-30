//
//  YQTRectangleTagView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTRectangleTagView.h"
#import "YQTRectangleTagContentView.h"
@interface YQTRectangleTagView()
@property(nonatomic,strong)YQTRectangleTagContentView *contentView;
@property(nonatomic,strong)UIImageView *mark;
@property(nonatomic,strong)YQTRectangleTagConfig *config;
@end
@implementation YQTRectangleTagView

+(instancetype)YQTRectangleTagWithConfig:(void (^)(YQTRectangleTagConfig *config))config {
    YQTRectangleTagView *view = [[YQTRectangleTagView alloc]init];
    !config?:config(view.config);
    [view setup];
    return view;
}
#pragma mark -- func
-(void)setup {
    [self addSubview:self.contentView];
    __weak typeof(self) weakself = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0).insets(weakself.config.contentInset);
    }];
    
    //mark
    [self addSubview:self.mark];
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat w = 24;
        make.trailing.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself);
        make.width.height.mas_equalTo(w);
    }];
}
#pragma mark -- lazy
-(UIImageView *)mark {
    if (!_mark) {
        _mark = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select.mark.YQTTagView"]];
        [_mark setHidden:self.contentView.selected];
    }
    return _mark;
}
-(YQTRectangleTagContentView *)contentView {
    if (!_contentView) {
        _contentView = [YQTRectangleTagContentView YQTRectangleTagContentViewWithConfig:self.config];
    }
    return _contentView;
}
-(YQTRectangleTagConfig *)config {
    if (!_config) {
        _config = [YQTRectangleTagConfig defaultConfig];
    }
    return _config;
}
-(void (^)(void))clickTagView {
    return ^(){
        self.contentView.selected = !self.contentView.selected;
        self.config.isSelect(self.contentView.selected);
        [self.mark setHidden:self.contentView.selected];
    };
}

-(BOOL)nowState {
    return  self.contentView.selected;
}

-(NSAttributedString *)attrStr {
    return [[NSAttributedString alloc]initWithString:self.config.text];
}

@end
