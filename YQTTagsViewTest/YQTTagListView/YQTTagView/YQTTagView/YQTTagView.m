//
//  YQTTagView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagView.h"
#import "Masonry.h"
#import "UIColor+Image.h"
@interface YQTTagView () {
    NSAttributedString *_attrStr;
    NSAttributedString *_selectedAttrStr;

}
@property(nonatomic,strong)UIView *line;
///config
@property(nonatomic,strong)YQTTagsViewConfig *config;

///contentview
@property(nonatomic,strong)UIButton *contentView;
@end
@implementation YQTTagView

+(instancetype)YQTTagWithConfig:(void (^)(YQTTagsViewConfig *config))config {
    YQTTagView *view = [[YQTTagView alloc]init];
    !config?:config(view.config);
    [view setup];
    return view;
}
-(void)setup {
    
    [self addSubview:self.contentView];
    __weak typeof(self) weakself = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0).insets(weakself.config.contentInset);
    }];
    
    //line
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakself.mas_centerY);
        make.leading.trailing.mas_equalTo(weakself);
        make.height.mas_equalTo(1);
    }];
    
}
#pragma mark lazy
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        [_line setHidden:!self.contentView.selected];
        [_line setBackgroundColor:self.config.lineColor];
    }
    return _line;
}

-(UIButton *)contentView {
    if (!_contentView) {
        
        _contentView = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _contentView.titleLabel.numberOfLines = 0;
        //button
        [_contentView setBackgroundImage:self.config.normalColor.image forState:(UIControlStateNormal)];
        [_contentView setBackgroundImage:self.config.selectedColor.image forState:(UIControlStateSelected)];
        
        _contentView.selected = self.config.select;
        
        [_contentView setAttributedTitle:self.attrStr forState:UIControlStateNormal];
        
        [_contentView setAttributedTitle:self.selectedAttrStr forState:UIControlStateSelected];
        
        //        [_contentView setTitle:self.config.text forState:(UIControlStateNormal)];
        //        [_contentView setTitle:self.config.text forState:(UIControlStateSelected)];
        
        
        [_contentView.titleLabel setFont:self.config.font];
        
        if (self.config.cornerRadius) {
            _contentView.layer.cornerRadius = self.config.cornerRadius;
            _contentView.layer.masksToBounds = YES;
        }
    }
    return _contentView;
}
-(YQTTagsViewConfig *)config {
    if (!_config) {
        _config = [YQTTagsViewConfig defaultConfig];
    }
    return _config;
}
-(NSAttributedString *)attrStr {
    if (!_attrStr) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.config.font forKey:NSFontAttributeName];
        [dic setValue:self.config.textColor forKey:NSForegroundColorAttributeName];
        
        _attrStr = [[NSAttributedString alloc]initWithString:self.config.text attributes:dic];
    }
    return _attrStr;
}
-(NSAttributedString *)selectedAttrStr {
    
    if (!_selectedAttrStr) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.config.font forKey:NSFontAttributeName];
        [dic setValue:self.config.selectedTitleColor forKey:NSForegroundColorAttributeName];
        
        [dic setValue:self.config.lineColor forKey:NSStrikethroughColorAttributeName];
        
        [dic setValue:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid) forKey:NSStrikethroughStyleAttributeName];
        _selectedAttrStr = [[NSAttributedString alloc]initWithString:self.config.text attributes:dic];
    }
    return _selectedAttrStr;
}
-(void (^)(void))clickTagView {
    return ^(){
        self.contentView.selected = !self.contentView.selected;
        self.config.isSelect(self.contentView.selected);
    };
}

-(BOOL)nowState {
    return  self.contentView.selected;
}
@end
