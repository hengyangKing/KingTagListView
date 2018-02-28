//
//  YQTTagBaseView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagBaseView.h"
#import "UIImage+Stretchable.h"
@interface YQTTagBaseView() {
    UILabel *_titleLabel;
    UIImageView *_bgImage;
    NSAttributedString *_attrTitle;
    NSAttributedString *_selectedAttrTitle;
    YQTTagsViewConfig *_tagConfig;
    UIImage *_normalBGImage;
    UIImage *_selectBGImage;
    
}
@property(nonatomic,assign)QTTagStates state;
@property(nonatomic,strong)NSMutableDictionary *imageDic;
@property(nonatomic,strong)NSMutableDictionary *titleDic;

@end

@implementation YQTTagBaseView
-(instancetype)init {
    self = [super init];
    if (self) {
        [self setBaseView];
    }
    return self;
}
-(void)setBaseView {
    self.userInteractionEnabled = NO;
    __weak typeof(self) weakself = self;
    [self addSubview:self.bgImage];

    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.mas_equalTo(weakself);
    }];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(weakself.bgImage)
        .insets(UIEdgeInsetsMake(ListTagMargin,ListTagPadding, ListTagMargin, ListTagPadding));
    }];
}
#pragma mark -- lazy
-(UIImageView *)bgImage {
    if (!_bgImage) {
        _bgImage =[[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _bgImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentLeft;        
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
-(NSMutableDictionary *)imageDic {
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionary];
    }
    return _imageDic;
}
-(NSMutableDictionary *)titleDic {
    if (!_titleDic) {
        _titleDic = [NSMutableDictionary dictionary];
    }
    return _titleDic;
}
-(YQTTagsViewConfig *)tagConfig {
    if (!_tagConfig) {
        _tagConfig = [YQTTagsViewConfig defaultConfig];
    }
    return _tagConfig;
}
-(NSAttributedString *)attrTitle {
    if (!_attrTitle) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.tagConfig.font forKey:NSFontAttributeName];
        [dic setValue:self.tagConfig.textColor forKey:NSForegroundColorAttributeName];
        
        _attrTitle = [[NSAttributedString alloc]initWithString:self.tagConfig.selectedTitle.length?self.tagConfig.selectedTitle:self.tagConfig.title attributes:dic];
    }
    return _attrTitle;
}
-(NSAttributedString *)selectedAttrTitle{
    
    if (!_selectedAttrTitle) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.tagConfig.font forKey:NSFontAttributeName];
        
        [dic setValue:self.tagConfig.selectedTextColor forKey:NSForegroundColorAttributeName];
        
        [dic setValue:self.tagConfig.lineColor forKey:NSStrikethroughColorAttributeName];
        
        [dic setValue:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid) forKey:NSStrikethroughStyleAttributeName];
        
        _selectedAttrTitle = [[NSAttributedString alloc]initWithString:self.tagConfig.selectedTitle.length?self.tagConfig.selectedTitle:self.tagConfig.title attributes:dic];
    }
    return _selectedAttrTitle;
}

-(UIImage *)normalBGImage {
    if (!_normalBGImage) {
        CGSize size = CGSizeMake(1, 1);
        if (self.tagConfig.cornerRadius) {
            size = CGSizeMake(self.tagConfig.cornerRadius*2, self.tagConfig.cornerRadius*2);
        }
        UIImage *image = [UIImage hyb_imageWithColor:self.tagConfig.bgColor toSize:size cornerRadius:self.tagConfig.cornerRadius backgroundColor:self.tagConfig.bgColor borderColor:self.tagConfig.borderColor borderWidth:self.tagConfig.borderWidth];
        _normalBGImage = image.stretchableImage;
        
    }
    return _normalBGImage;
}
-(UIImage *)selectBGImage {
    if (!_selectBGImage) {
        CGSize size = CGSizeMake(1, 1);
        if (self.tagConfig.cornerRadius) {
            size = CGSizeMake(self.tagConfig.cornerRadius*2, self.tagConfig.cornerRadius*2);
        }
        UIImage *image = [UIImage hyb_imageWithColor:self.tagConfig.selectedBGColor toSize:size cornerRadius:self.tagConfig.cornerRadius backgroundColor:self.tagConfig.selectedBGColor borderColor:self.tagConfig.selectedBorderColor borderWidth:self.tagConfig.borderWidth];
        _selectBGImage = image.stretchableImage;
    }
    return _selectBGImage;
}
#pragma mark  -- set
-(void)setSelected:(BOOL)selected {
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
#pragma mark -- readonly
-(BOOL)nowState {
    return  self.selected;
}
#pragma mark -- func
-(void)layoutUI {
    
    [self setbgImage:self.normalBGImage withState:(QTTagStateNormal)];
    
    [self setbgImage:self.selectBGImage withState:(QTTagStateSelected)];
    
    [self setAttr:self.attrTitle withState:QTTagStateNormal];
    
    [self setAttr:self.selectedAttrTitle withState:QTTagStateSelected];
    
    [self setSelected:self.tagConfig.select];
}



///设置背景图片
-(void)setbgImage:(UIImage *)image withState:(QTTagStates)state {
    [self.imageDic setValue:image forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:state]]];
}


///设置符文本字体
-(void)setAttr:(NSAttributedString *)attr withState:(QTTagStates)state {
    [self.titleDic setValue:attr forKey:[NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:state]]];
}


-(void (^)(void))clickTagView {
    return ^(){
        self.selected = !self.selected;
        self.tagConfig.isSelect(self.selected);
    };
}
@end
