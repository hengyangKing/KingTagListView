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

@interface YQTRowTagView()
@property(nonatomic,strong)YQTTagView *contentView;
@end
@implementation YQTRowTagView
+(instancetype)YQTRowTagWithConfig:(void (^)(YQTTagsViewConfig *config))config {
    YQTRowTagView *rowTagView = [[YQTRowTagView alloc]init];
    rowTagView.contentView = [YQTTagView YQTTagWithConfig:config];
    return rowTagView;
}
-(void)setContentView:(YQTTagView *)contentView {
    self.backgroundColor = [UIColor yellowColor];

    _contentView = contentView;
    [self addSubview:_contentView];
    __weak typeof(self) weakself = self;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(weakself);
        make.width.mas_equalTo(weakself.attrStr.rowContentSize.width);
    }];

}

#pragma mark -- func
-(NSAttributedString *)attrStr {
    return self.contentView.attrStr;
}

-(void (^)(void))clickTagView {
    return self.contentView.clickTagView;
}

-(BOOL)nowState {
    return  self.contentView.nowState;
}




@end
