//
//  YQTTagView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
// 用于布置作业列表controller tags view 

#import <UIKit/UIKit.h>
#import "YQTTagsViewConfig.h"

@interface YQTTagView : UIView

+(instancetype)YQTTagWithConfig:(void (^)(YQTTagsViewConfig *config))config;

//反选当前Tag状态
@property(nonatomic,readonly,copy)void (^clickTagView)(void);

///用于计算内容
@property(nonatomic,copy,readonly)NSAttributedString *attrStr;

///当前tag是否被选中
@property(nonatomic,assign,readonly)BOOL nowState;





@end
