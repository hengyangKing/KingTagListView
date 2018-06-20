//
//  YQTRectangleTagView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTRectangleTagView.h"
@interface YQTRectangleTagView () {
    NSAttributedString *_attrTitle;
    NSAttributedString *_selectedAttrTitle;
}

@property(nonatomic,strong)UIImageView *mark;
@end
@implementation YQTRectangleTagView

+(instancetype)YQTRectangleTagWithConfig:(void (^)(YQTTagsViewConfig *config))config {
    YQTRectangleTagView *view = [[YQTRectangleTagView alloc]init];
    !config?:config(view.tagConfig);
    [view layoutUI];
    return view;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        
        self.tagConfig.normalBorderColor(Color(@"#E4E4E6"));
        self.tagConfig.selectBorderColor(Color(@"#15A6EE"));
        
        self.tagConfig.normalTitleColor(Color(@"#90969E"));
        self.tagConfig.selectTitleColor(Color(@"#3EA7DB"));
        
        self.tagConfig.normalBGColor(Color(@"#FFFFFF"));
        self.tagConfig.selectBGColor(Color(@"#ECF9FF"));
        
    }
    return self;
}
#pragma mark -- func
-(void)layoutUI {
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    __weak typeof(self) weakself = self;
    [self.bgImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0).insets(weakself.tagConfig.contentInset);
    }];

    [self addSubview:self.mark];
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat w = 24;
        make.trailing.mas_equalTo(weakself);
        make.top.mas_equalTo(weakself);
        make.width.height.mas_equalTo(w);
    }];
    [self.mark setHidden:!self.tagConfig.select];
    [super layoutUI];
}
#pragma mark -- lazy
-(UIImageView *)mark {
    if (!_mark) {
        _mark = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select.mark.YQTTagView"]];
    }
    return _mark;
}
#pragma mark -- 重写
-(NSAttributedString *)attrTitle{
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
        _selectedAttrTitle = [[NSAttributedString alloc]initWithString:self.tagConfig.selectedTitle.length?self.tagConfig.selectedTitle:self.tagConfig.title attributes:dic];
    }
    return _selectedAttrTitle;
}
-(void (^)(void))clickTagView {
    return ^(){
        self.selected = !self.selected;
        self.tagConfig.isSelect(self.selected);
        [self.mark setHidden:!self.selected];
    };
}

@end
