//
//  YQTTagListCommon.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#ifndef YQTTagListCommon_h
#define YQTTagListCommon_h

#import "TTGTagCollectionView.h"

#define TagListHeaderH 24.f //headerView 高度
#define ListTagPadding 16.f //tagview边距

#define YQTFONT(A) [UIFont fontWithName:@"PingFangSC-Regular"size:A]

//上部tag 列表排列方式
typedef NS_ENUM(NSUInteger, YQTTagListArrangeType) {
    YQTTagListArrangeTypeIsTag,//tag 排列
    YQTTagListArrangeTypeIsRow,//单行排列
    YQTTagListArrangeTypeIsRectangle,//块排列
};

///TagListHeaderButtonState
typedef NS_ENUM(NSUInteger, TagListHeaderButtonState) {
    
    ButtonStateIsSelectAll,///默认状态为全选 对应button select = no
    ButtonStateIsUnSelectAll,///当前状态为取消全选 对应button select = yes
};

#endif /* YQTTagListCommon_h */
