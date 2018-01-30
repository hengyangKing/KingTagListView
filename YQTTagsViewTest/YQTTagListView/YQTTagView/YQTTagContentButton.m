//
//  YQTTagContentButton.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagContentButton.h"
#import "YQTTagListCommon.h"
@implementation YQTTagContentButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup {
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.numberOfLines = 0;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(self).insets(UIEdgeInsetsMake(ListTagMargin,ListTagPadding, ListTagMargin, ListTagPadding));
    }];

}

@end
