//
//  YQTRowTagView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTRowTagView.h"
#import "YQTTagView.h"
#import "NSAttributedString+TagSize.h"
@implementation YQTRowTagView
+(instancetype)YQTRowTagWithConfig:(void (^)(YQTTagsViewConfig *config))config {
    YQTRowTagView *view = [[YQTRowTagView alloc]init];
    !config?:config(view.tagConfig);
    [view setupUI];
    return view;
}
-(void)setupUI {
    __weak typeof(self) weakself = self;
    [self.bgImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(weakself);
        make.width.mas_equalTo(weakself.attrTitle.rowContentSize.width);
    }];
    [self layoutUI];
}
@end
