//
//  YQTTagListBaseCellModel.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagBaseView.h"
//展开title
#define UnfoldTitle(X,W) [NSString stringWithFormat:@"展示全部%@个%@",@(X),W]

#define HeaderTitlt(W) [NSString stringWithFormat:@"点击划掉不用的%@",W]


@interface YQTTagListBaseCellModel : NSObject

@property(nonatomic,copy)NSArray<YQTTagBaseView *> *tags;
@property(nonatomic,copy)NSString *headerTitle;
@property(nonatomic,copy)NSString *unfoldTitle;
@property(nonatomic,assign)BOOL hiddenHeaderButton;
@property(nonatomic,assign)CGFloat contentHSpacing;//横向间距
@property(nonatomic,assign)CGFloat contentVSpacing;//纵向间距

+(instancetype)YQTTagListBaseCellModel;

@end
