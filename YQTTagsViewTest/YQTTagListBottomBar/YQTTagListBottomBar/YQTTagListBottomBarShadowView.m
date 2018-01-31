//
//  YQTTagListBottomBarShadowView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBarShadowView.h"
#import "Masonry.h"

@implementation YQTTagListBottomBarShadowView

-(void)didMoveToSuperview {
    [self setNeedsUpdateConstraints];
}
#pragma mark -- MAS
// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    __weak typeof(self) weakself = self;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(weakself.superview);
        make.height.mas_equalTo(1);
    }];
    [super updateConstraints];
}

@end
