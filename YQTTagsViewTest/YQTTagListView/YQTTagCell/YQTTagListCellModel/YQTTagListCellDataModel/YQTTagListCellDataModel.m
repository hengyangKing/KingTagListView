//
//  YQTTagListCellDataModel.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListCellDataModel.h"
@implementation YQTTagListCellAppearanceModel
-(instancetype)init {
    self = [super init];
    if (self) {
        self.numberOfLines = 0;
        self.needRefashion = NO;
        self.canDrawBack = YES;
        self.canFlex = YES;
    }
    return self;
}
@end
@implementation YQTTagListCellModel

@end
@interface YQTTagListCellDataModel() {
    YQTTagListCellAppearanceModel *_appearModel;
}
@end
@implementation YQTTagListCellDataModel

-(YQTTagListCellAppearanceModel *)appearModel {
    if (!_appearModel) {
        _appearModel = [[YQTTagListCellAppearanceModel alloc]init];
    }
    return _appearModel;
}
@end
