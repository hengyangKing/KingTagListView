//
//  YQTTagBaseView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//  抽象父类

#import <UIKit/UIKit.h>
#import "YQTTagsViewConfig.h"



typedef NS_ENUM(NSUInteger, QTTagStates) {
    QTTagStateNormal,//tag 正常状态
    QTTagStateSelected,// tag 选中状态
};

@interface YQTTagBaseView : UIView

//反选当前Tag状态
@property(nonatomic,readonly,copy)void (^clickTagView)(void);

///用于计算内容
@property(nonatomic,copy,readonly)NSAttributedString *attrStr;

///当前tag 状态
@property(nonatomic,assign,readonly)BOOL nowState;


///设置当前选中状态
@property(nonatomic,assign)BOOL selected;

///titlelabel
@property(nonatomic,strong,readonly)UILabel *titleLabel;

///设置背景图片
-(void)setbgImage:(UIImage *)image withState:(QTTagStates)state;

///设置符文本字体
-(void)setAttr:(NSAttributedString *)attr withState:(QTTagStates)state;


///外观
@property(nonatomic,strong,readonly)void (^baseConfig)(YQTTagsViewConfig *config);

@end
