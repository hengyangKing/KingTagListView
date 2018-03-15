//
//  YQTTagListCustomButton.h
//  YQTTagsViewTest
//
//  Created by J on 2018/3/14.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTButtonAppearanceConfig.h"

@interface YQTTagListCustomButton : UIButton
+(instancetype)createCustomButtonWithConfig:(void (^)(YQTButtonAppearanceConfig *))config;

@property(nonatomic,copy,readonly)void (^YQTTagListCustomButtonNormalTitle)(NSString *title);

@property(nonatomic,copy,readonly)void (^YQTTagListCustomButtonSelectTitle)(NSString *title);



@end
