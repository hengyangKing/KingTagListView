//
//  YQTBottomBarButton.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTBottomBarButtonConfig.h"

@interface YQTBottomBarButton : UIButton
+(instancetype)createBottomBarButtonWithConfig:(void (^)(YQTBottomBarButtonConfig *))config;

@end
