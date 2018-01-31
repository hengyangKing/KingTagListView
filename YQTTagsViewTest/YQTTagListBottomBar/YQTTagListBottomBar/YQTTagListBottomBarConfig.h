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

@property(nonatomic,assign,readonly)UIEdgeInsets contentInset;

@property(nonatomic,assign,readonly)BOOL needCornerRadius;

@property(nonatomic,strong,readonly)UIImage *shadow;

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarCostom)(UIView *);

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarBGColor)(UIColor *);

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^bottomBarShadow)(UIImage *);


@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^costomInset)(UIEdgeInsets contentInset);

@property(nonatomic,copy,readonly)YQTTagListBottomBarConfig *(^needCostomCornerRadius)(BOOL needRadius);



@end
