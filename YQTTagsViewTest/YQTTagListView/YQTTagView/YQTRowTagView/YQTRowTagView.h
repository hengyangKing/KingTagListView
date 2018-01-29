//
//  YQTRowTagView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagsViewConfig.h"
@interface YQTRowTagView : UIView

+(instancetype)YQTRowTagWithConfig:(void (^)(YQTTagsViewConfig *config))config;

//反选当前Tag状态
@property(nonatomic,readonly,copy)void (^clickTagView)(void);

///用于计算内容
@property(nonatomic,copy,readonly)NSAttributedString *attrStr;

///当前tag是否被选中
@property(nonatomic,assign,readonly)BOOL nowState;


@end
