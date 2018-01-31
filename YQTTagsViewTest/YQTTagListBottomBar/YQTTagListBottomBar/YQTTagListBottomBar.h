//
//  YQTTagListBottomBar.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagListBottomBarConfig.h"
#import "Masonry.h"

@interface YQTTagListBottomBar : UIView
+(instancetype)createBottomBarWithConfig:(void (^)(YQTTagListBottomBarConfig *))config ;

-(CGFloat)barH;

-(void)dismiss;

-(void)show;


@end
