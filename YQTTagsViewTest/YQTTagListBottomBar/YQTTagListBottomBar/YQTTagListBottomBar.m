//
//  YQTTagListBottomBar.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBar.h"
@interface YQTTagListBottomBar()
@property(nonatomic,strong)YQTTagListBottomBarConfig *config;
@end
@implementation YQTTagListBottomBar

+(instancetype)createBottomBarWithConfig:(void (^)(YQTTagListBottomBarConfig *))config andCostomConstraints:(void (^)(MASConstraintMaker *make))constraints {
    YQTTagListBottomBar *bar = [[YQTTagListBottomBar alloc]init];
    !config? : config(bar.config);
    [bar setup];
    [bar.config.costom mas_makeConstraints:constraints];
    return bar;

}
#pragma mark -- lazy
-(YQTTagListBottomBarConfig *)config{
    if (!_config) {
        _config = [YQTTagListBottomBarConfig defaultConfig];
    }
    return _config;
}
#pragma mark -- func
-(void)setup {
    [self addSubview:self.config.costom];
    self.backgroundColor = self.config.bgColor;
}

@end
