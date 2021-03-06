//
//  YQTTagBaseView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//  TagView 抽象父类 

#import <UIKit/UIKit.h>
#import "YQTTagsViewConfig.h"

typedef NS_ENUM(NSUInteger, QTTagStates) {
    QTTagStateNormal,//tag 正常状态
    QTTagStateSelected,// tag 选中状态
};

@interface YQTTagBaseView : UIView

//反选当前Tag状态
@property(nonatomic,readonly,copy)void (^clickTagView)(void);


///设置当前选中状态
@property(nonatomic,assign)BOOL selected;

///titlelabel
@property(nonatomic,strong,readonly)UILabel *titleLabel;

///bgImageview
@property(nonatomic,strong,readonly)UIImageView *bgImage;


/////子类设置外观调用


///子类调用父类外观调用
@property(nonatomic,strong,readonly)YQTTagsViewConfig *tagConfig;

///父类使用的符文本字符串 子类可以重写
@property(nonatomic,copy,readonly)NSAttributedString *attrTitle;

///父类使用的符文本字符串 子类可以重写
@property(nonatomic,copy,readonly)NSAttributedString *selectedAttrTitle;

//子类完成设置 通知父类刷新UI
-(void)layoutUI;



@end
