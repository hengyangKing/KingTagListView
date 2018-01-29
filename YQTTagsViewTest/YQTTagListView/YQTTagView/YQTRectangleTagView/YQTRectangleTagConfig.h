//
//  YQTRectangleTagConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagsViewConfig.h"

@interface YQTRectangleTagConfig : YQTTagsViewConfig

@property(nonatomic,strong,readonly)UIColor *tintColor;
@property(nonatomic,strong,readonly)UIColor *selectTintColor;
///边框宽度
@property(nonatomic,assign,readonly)CGFloat borderW;


///风格颜色 其为边框颜色和字体颜色
@property(nonatomic,copy,readonly)YQTRectangleTagConfig *(^rectTagTintColor)(UIColor *color);
@property(nonatomic,copy,readonly)YQTRectangleTagConfig *(^rectTagSelectTintColor)(UIColor *color);
///边框宽度
@property(nonatomic,copy,readonly)YQTRectangleTagConfig *(^rectTagBorderW)(CGFloat width);


@end
