//
//  UIView+Shadow.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)
-(void)addShadowWithColor:(UIColor *)color Radius:(CGFloat)radius;
-(void)showShadow;
-(void)hiddenShadow;

@end
