//
//  YQTBottomBarButtonConfig.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTBottomBarButtonConfig : NSObject
+(instancetype)defaultConfig;
//行为
@property(nonatomic,strong,readonly)id target;
@property(nonatomic,assign,readonly)SEL sel;

//外观
@property(nonatomic,copy,readonly)NSString *title;
@property(nonatomic,strong,readonly)UIImage *image;
@property(nonatomic,strong,readonly)UIColor *bgColor;
@property(nonatomic,strong,readonly)UIColor *titleColor;

@property(nonatomic,assign,readonly,getter=isShowBorder)BOOL showBorder;
@property(nonatomic,assign,readonly)CGFloat borderWidth;
@property(nonatomic,strong,readonly)UIColor *borderColor;
@property(nonatomic,strong,readonly)UIFont *font;


@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonTarget)(id target);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonSEL)(SEL sel);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonTitle)(NSString *title);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonBGColor)(UIColor *color);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonImage)(NSString *name);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonTitleColor)(UIColor *color);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonTitleFont)(UIFont *font);

//Border
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonShowBorder)(BOOL showBorder);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonBorderWidth)(CGFloat borderWidth);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQTButtonBorderColor)(UIColor *color);

@end
