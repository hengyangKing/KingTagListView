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
@property(nonatomic,assign,readonly)CGFloat cornerRadius;
@property(nonatomic,strong,readonly)UIFont *font;


@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonTarget)(id target);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonSEL)(SEL sel);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonTitle)(NSString *title);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonBGColor)(UIColor *color);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonImage)(NSString *name);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonTitleColor)(UIColor *color);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonTitleFont)(UIFont *font);

//Border
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonShowBorder)(BOOL showBorder);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonBorderWidth)(CGFloat borderWidth);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonBorderColor)(UIColor *color);
@property(nonatomic,copy,readonly)YQTBottomBarButtonConfig *(^YQYButtonBorderCornerRadius)(CGFloat cornerRadius);

@end
