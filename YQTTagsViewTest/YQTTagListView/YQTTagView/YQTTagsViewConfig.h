//
//  YQTTagsViewConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
// 该类为老师端布置作业 和 句型 tag列表外观设置


#import "YQTTagViewBaseConfig.h"


@interface YQTTagsViewConfig : YQTTagViewBaseConfig
#pragma mark getPar

@property(nonatomic,strong,readonly)UIColor *normalColor;
@property(nonatomic,strong,readonly)UIColor *selectedColor;
@property(nonatomic,strong,readonly)UIColor *selectedTitleColor;
@property(nonatomic,strong,readonly)UIColor *lineColor;


// Content inset, default is UIEdgeInsetsMake(0, 0, 0, 0).
@property(nonatomic,assign,readonly)UIEdgeInsets contentInset;

///当前view的选中状态
@property(nonatomic,assign,readonly)BOOL select;

///显示的文本
@property(nonatomic,copy,readonly)NSString *text;

#pragma mark setPar

///bgColor
@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^normalBGColor)(UIColor *color);
///select bgColor
@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^selectedBGColor)(UIColor *color);

@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^selectedTitleTextColor)(UIColor *color);

///line color
@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^delineColor)(UIColor *color);

///content view inset
@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^contentViewInset)(UIEdgeInsets inset);

@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^isSelect)(BOOL select);

@property(nonatomic,copy,readonly)YQTTagsViewConfig *(^titleText)(NSString *text);

+(instancetype)defaultConfig;

@end
