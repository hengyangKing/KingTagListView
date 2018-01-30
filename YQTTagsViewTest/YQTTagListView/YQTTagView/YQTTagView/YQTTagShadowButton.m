//
//  YQTTagShadowButton.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagShadowButton.h"
#import "UIView+Shadow.h"
#import "UIColor+YQKit.h"

@implementation YQTTagShadowButton
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.selected) {
        [self hiddenShadow];
    }else{
        [self showShadow];
    }
}
- (void)didMoveToSuperview {
    [self addShadowWithColor:[UIColor colorWithHexString:@"#DDE1E8" alpha:.5f] Radius:self.layer.cornerRadius];
}

@end
