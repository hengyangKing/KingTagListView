//
//  YQTMultiLineRectangleTagView.m
//  YQTTagsViewTest
//
//  Created by king on 2018/6/20.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTMultiLineRectangleTagView.h"
@interface YQTMultiLineRectangleTagView() {
    NSAttributedString *_attrTitle;
    NSAttributedString *_selectedAttrTitle;
}
@end
@implementation YQTMultiLineRectangleTagView

+(instancetype)YQTMultiLineRectangleTagWithConfig:(void (^)(YQTTagsViewConfig *config))config {
    YQTMultiLineRectangleTagView *view = [[YQTMultiLineRectangleTagView alloc]init];
    !config?:config(view.tagConfig);
    [view layoutUI];
    return view;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        self.tagConfig.normalBorderColor(Color(@"#F5F6F8"));
        self.tagConfig.selectBorderColor(Color(@"#007AFF"));
        
        self.tagConfig.normalTitleColor(Color(@"#58595E"));
        self.tagConfig.selectTitleColor(Color(@"#007AFF"));
        
        self.tagConfig.normalBGColor(Color(@"#F5F6F8"));
        self.tagConfig.selectBGColor(Color(@"#F2F8FF"));
        
        self.tagConfig.titleFont(12);
        self.tagConfig.radius(3.f);
    }
    return self;
}
#pragma mark -- 重写
-(NSAttributedString *)attrTitle {
    if (!_attrTitle) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.tagConfig.font forKey:NSFontAttributeName];
        [dic setValue:self.tagConfig.textColor forKey:NSForegroundColorAttributeName];
        [dic setValue:@(0.0) forKey:NSKernAttributeName];
        
        _attrTitle = [[NSAttributedString alloc]initWithString:self.tagConfig.selectedTitle.length?self.tagConfig.selectedTitle:self.tagConfig.title attributes:dic];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithAttributedString:_attrTitle];
        NSRange range = NSMakeRange(0, _attrTitle.length);
        // 调整行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0];
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        _attrTitle = attr;
    }
    return _attrTitle;
}
-(NSAttributedString *)selectedAttrTitle {
    
    if (!_selectedAttrTitle) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.tagConfig.font forKey:NSFontAttributeName];
        [dic setValue:self.tagConfig.selectedTextColor forKey:NSForegroundColorAttributeName];
        [dic setValue:@(0.0) forKey:NSKernAttributeName];

        _selectedAttrTitle = [[NSAttributedString alloc]initWithString:self.tagConfig.selectedTitle.length?self.tagConfig.selectedTitle:self.tagConfig.title attributes:dic];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithAttributedString:_selectedAttrTitle];
        NSRange range = NSMakeRange(0, _selectedAttrTitle.length);
        // 调整行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:0.00001];
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
        _selectedAttrTitle = attr;
    }
    return _selectedAttrTitle;
}
-(void)layoutUI {
    self.titleLabel.numberOfLines = 0;
    __weak typeof(self) weakself = self;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(weakself.bgImage)
        .insets(UIEdgeInsetsMake(ListTagMargin-3.0,10, ListTagMargin-3.0, 10));
    }];
    [super layoutUI];
}


@end
