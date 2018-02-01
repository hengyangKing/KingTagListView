//
//  YQTTagListBaseCellModel.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBaseCellModel.h"

@implementation YQTTagListBaseCellModel
+(instancetype)YQTTagListBaseCellModel {
    YQTTagListBaseCellModel *model = [[YQTTagListBaseCellModel alloc]init];
    model.contentHSpacing = 14.f;
    model.contentVSpacing = 14.f;

    model.hiddenHeaderButton = NO;
    model.headerTitle = @"";
    model.tags = @[];
    return model;
}
@end
