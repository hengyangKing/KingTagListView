//
//  YQTTagListBottomBarConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTTagListBottomBarConfig : NSObject
+(instancetype)defaultConfig;

@property(nonatomic,strong,readonly)UIView *costom;

@property(nonatomic,strong,readonly)UIColor *bgColor;

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarCostom)(UIView *);
@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarBGColor)(UIColor *);

@end
