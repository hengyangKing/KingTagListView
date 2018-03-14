//
//  YQTTagListCellDataModel.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListCellDataModel.h"
@implementation YQTTagListCellModel

@end
@implementation YQTTagListCellDataModel
-(instancetype)init {
    self = [super init];
    if (self) {
        self.numberOfLines = 0;
        self.unfoldDatas = NO;
    }
    return self;
}
@end
