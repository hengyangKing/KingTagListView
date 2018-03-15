//
//  YQTTagListCustomButton+Hidden.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/15.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListCustomButton+Hidden.h"
@implementation YQTTagListCustomButton (Hidden)
-(void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (self.superview) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hidden?0:TagListFootH).priority(999);
        }];
    }
}
@end
