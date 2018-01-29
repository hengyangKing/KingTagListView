//
//  YQTRectangleTagContentView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTRectangleTagContentView.h"
#import "UIColor+Image.h"
#import "Masonry.h"
@interface YQTRectangleTagContentView()
@property(nonatomic,strong)YQTRectangleTagConfig *config;
@end
@implementation YQTRectangleTagContentView

+(instancetype)YQTRectangleTagContentViewWithConfig:(YQTRectangleTagConfig *)config {
    
    YQTRectangleTagContentView *contentView= [YQTRectangleTagContentView buttonWithType:(UIButtonTypeCustom)];
    
    contentView.config = config;
    
    contentView.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    contentView.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [contentView setBackgroundImage:contentView.config.normalColor.image forState:(UIControlStateNormal)];
    [contentView setBackgroundImage:contentView.config.selectedColor.image forState:(UIControlStateSelected)];
    
    contentView.selected = contentView.config.select;
    
    [contentView setTitle:contentView.config.text forState:(UIControlStateNormal)];
    [contentView setTitle:contentView.config.text forState:(UIControlStateSelected)];
    [contentView setTitleColor:contentView.config.tintColor forState:(UIControlStateNormal)];
    [contentView setTitleColor:contentView.config.selectTintColor forState:(UIControlStateSelected)];
    
    [contentView.titleLabel setFont:contentView.config.font];
    
    if (contentView.config.cornerRadius) {
        contentView.layer.cornerRadius = contentView.config.cornerRadius;
        contentView.layer.masksToBounds = YES;
    }
    [contentView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(contentView).insets(UIEdgeInsetsMake(0, 6, 0, 6));
    }];
    
    return contentView;
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (self.config.borderW) {
        if (!self.selected) {
            self.layer.borderColor = self.config.tintColor.CGColor;
        }else{
            self.layer.borderColor = self.config.selectTintColor.CGColor;
        }
        self.layer.borderWidth = self.config.borderW;
    }
}

@end
