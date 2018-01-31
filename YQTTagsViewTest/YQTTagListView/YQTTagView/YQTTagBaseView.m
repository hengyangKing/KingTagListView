//
//  YQTTagBaseView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagBaseView.h"
#import "UIColor+Image.h"

@interface YQTTagBaseView() {
    UILabel *_titleLabel;
}
@property(nonatomic,strong)UIImageView *bgImage;
@property(nonatomic,assign)QTTagStates state;
@property(nonatomic,strong)NSMutableDictionary *imageDic;
@property(nonatomic,strong)NSMutableDictionary *titleDic;
@property(nonatomic,strong)YQTTagsViewConfig *baseTagConfig;

@end

@implementation YQTTagBaseView
-(instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup {
    self.userInteractionEnabled = NO;

    [self addSubview:self.bgImage];
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(0);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(self).insets(UIEdgeInsetsMake(ListTagMargin,ListTagPadding, ListTagMargin, ListTagPadding));
    }];
    
}
#pragma mark -- lazy
-(UIImageView *)bgImage
{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _bgImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
-(NSMutableDictionary *)imageDic
{
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionary];
    }
    return _imageDic;
}
-(NSMutableDictionary *)titleDic
{
    if (!_titleDic) {
        _titleDic = [NSMutableDictionary dictionary];
    }
    return _titleDic;
}
-(void (^)(YQTTagsViewConfig *))baseConfig
{
    return ^(YQTTagsViewConfig *config){
        [self setBaseTagConfig:config];
    };
}

#pragma mark  -- set
-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setState:_selected?QTTagStateSelected:QTTagStateNormal];
}
-(void)setState:(QTTagStates)state {
    _state = state;
    UIImage *image = [self.imageDic valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:state]]];
    if (image) {
        [self.bgImage setImage:image];
    }
    
    NSAttributedString *attr = [self.titleDic valueForKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:state]]];
    if (attr) {
        [self.titleLabel setAttributedText:attr];
    }
}
///设置背景图片
-(void)setbgImage:(UIImage *)image withState:(QTTagStates)state {
    [self.imageDic setValue:image forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:state]]];
}


///设置符文本字体
-(void)setAttr:(NSAttributedString *)attr withState:(QTTagStates)state {
    [self.titleDic setValue:attr forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:state]]];
}
-(void)setBaseTagConfig:(YQTTagsViewConfig *)baseTagConfig
{
    _baseTagConfig = baseTagConfig;
    [self setbgImage:_baseTagConfig.normalColor.image withState:(QTTagStateNormal)];
    
    [self setbgImage:_baseTagConfig.selectedColor.image withState:(QTTagStateSelected)];
    [self setSelected:_baseTagConfig.select];
}
-(BOOL)nowState {
    return  self.selected;
}
@end
