//
//  YQTTagListBottomBar+CreateBar.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBar+CreateBar.h"
#import "YQTTagListCustomButton.h"
#import "UIColor+YQKit.h"
#define VerticalMargin 15
#define HorizontalMargin 16
@implementation YQTTagListBottomBar (CreateBar)
+(instancetype)createTagListBottomBarWithSEL:(SEL)sel andTarget:(id)target{
    return [YQTTagListBottomBar createBottomBarWithConfig:^(YQTTagListBottomBarConfig *config) {
        
        config.bottomBarCostom([YQTTagListCustomButton createCustomButtonWithConfig:^(YQTButtonAppearanceConfig *config) {
            config.normalTitle(@"提交").selectTitle(@"提交");
            config.YQTButtonSEL(sel).YQTButtonTarget(target);
            config.radius((BarContentHeight-(2*VerticalMargin))/2.0f);
        }]).costomInset(UIEdgeInsetsMake(VerticalMargin, HorizontalMargin, VerticalMargin, HorizontalMargin)).bottomBarShadow([UIImage hyb_imageWithColor:[UIColor colorWithHexString:@"#E2E2E2"] toSize:CGSizeMake(1, 1)]);
        
        
    }];
}
@end
