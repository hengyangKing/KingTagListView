//
//  YQTTagListAppearanceConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/3/13.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagListCommon.h"
#import "UIColor+YQKit.h"
@interface YQTTagListAppearanceConfig : NSObject
///button圆角半径
@property(nonatomic,assign,readonly)CGFloat cornerRadius;

///边框宽度
@property(nonatomic,assign,readonly)CGFloat borderWidth;


///圆角半径
@property(nonatomic,copy,readonly)YQTTagListAppearanceConfig *(^radius)(CGFloat radius);
///边框宽度
@property(nonatomic,copy,readonly)YQTTagListAppearanceConfig *(^borderW)(CGFloat width);

@end
