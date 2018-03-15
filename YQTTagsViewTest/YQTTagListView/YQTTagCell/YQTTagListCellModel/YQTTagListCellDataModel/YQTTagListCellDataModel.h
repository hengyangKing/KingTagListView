//
//  YQTTagListCellDataModel.h
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import <Foundation/Foundation.h>

///tag 展示数据模型
@interface YQTTagListCellModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL selected;
@end
///taglistcell 外观模型
@interface YQTTagListCellAppearanceModel : NSObject
///展示行数 默认0
@property(nonatomic,assign)NSUInteger numberOfLines;

///是否具备可伸缩功能
///实际行数 小于规定展示 行数时 不具备可伸缩功能
@property(nonatomic,assign)BOOL canFlex;

///展示完全数据后 是否需要收缩功能 是否隐藏button
@property(nonatomic,assign)BOOL canDrawBack;

///刷新标识 需要 重绘
@property(nonatomic,assign)BOOL needRefashion;

@end

@interface YQTTagListCellDataModel : NSObject
///tags 数据源
@property(nonatomic,copy)NSArray <YQTTagListCellModel *>*datas;

@property(nonatomic,strong,readonly)YQTTagListCellAppearanceModel *appearModel;

@end
