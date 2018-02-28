//
//  YQTTagListBottomBar+CreateBar.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBar+CreateBar.h"
#import "YQTBottomBarButton.h"
#import "HYBImageCliped.h"
#import "UIColor+YQKit.h"

@implementation YQTTagListBottomBar (CreateBar)
+(instancetype)createTagListBottomBarWithSEL:(SEL)sel andTarget:(id)target{
    return [YQTTagListBottomBar createBottomBarWithConfig:^(YQTTagListBottomBarConfig *config) {
        
        config.bottomBarCostom([YQTBottomBarButton createBottomBarButtonWithConfig:^(YQTBottomBarButtonConfig *config) {
            config.YQTButtonSEL(sel).YQTButtonTarget(target).YQTButtonTitle(@"提交");
        }]).costomInset(UIEdgeInsetsMake(15, 16, 15, 16)).bottomBarShadow([UIImage hyb_imageWithColor:[UIColor colorWithHexString:@"#E2E2E2"] toSize:CGSizeMake(1, 1)]);
        
    }];
}
@end
