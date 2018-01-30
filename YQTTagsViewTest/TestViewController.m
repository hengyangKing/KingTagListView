//
//  TestViewController.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/27.
//  Copyright © 2018年 J. All rights reserved.
//

#import "TestViewController.h"
#import "YQTTagListBottomBar.h"
#import "YQTBottomBarButton.h"


@interface TestViewController ()
@property(nonatomic,strong)YQTTagListBottomBar *bar;
@end

@implementation TestViewController
-(YQTTagListBottomBar *)bar {
    if (!_bar) {
        __weak typeof(self) weakself = self;
        _bar = [YQTTagListBottomBar createBottomBarWithConfig:^(YQTTagListBottomBarConfig *config) {
            
            config.bottomBarCostom([YQTBottomBarButton createBottomBarButtonWithConfig:^(YQTBottomBarButtonConfig *config) {
                config.YQTButtonSEL(@selector(foo)).YQTButtonTarget(weakself).YQTButtonTitle(@"提交");
            }]).costomInset(UIEdgeInsetsMake(15, 16, 15, 16));
        }];
    }
    return _bar;
}
-(void)foo
{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bar];
    
}

@end
