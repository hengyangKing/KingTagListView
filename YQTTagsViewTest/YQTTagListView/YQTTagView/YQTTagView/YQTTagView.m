//
//  YQTTagView.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
//  该类为展示的tag 需添加阴影

#import "YQTTagView.h"
#import "HYBImageCliped.h"

@interface YQTTagView () 

@end
@implementation YQTTagView

+(instancetype)YQTTagWithConfig:(void (^)(YQTTagsViewConfig *config))config {
    YQTTagView *view = [[YQTTagView alloc]init];
    !config?:config(view.tagConfig);
    [view layoutUI];
    return view;
}

@end
