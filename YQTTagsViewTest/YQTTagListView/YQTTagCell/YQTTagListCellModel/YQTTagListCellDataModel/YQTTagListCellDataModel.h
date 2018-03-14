//
//  YQTTagListCellDataModel.h
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YQTTagListCellModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL selected;
@end

@interface YQTTagListCellDataModel : NSObject
///tags 数据源
@property(nonatomic,copy)NSArray <YQTTagListCellModel *>*datas;
///展示行数 默认0
@property(nonatomic,assign)NSUInteger numberOfLines;
///刷新标识 需要展开数据
@property(nonatomic,assign)BOOL unfoldDatas;

@end
