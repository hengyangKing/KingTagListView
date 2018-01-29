//
//  YQTTagZoomButton.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/27.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQTTagZoomButton : UIButton


/**
 构造动画button

 @param animate 动画执行前调用block
 @param completion 点击完成后执行block 先于动画执行
 @return 反会button 对象
 */
+(instancetype)zoomButtonAnimateWidth:(CGFloat (^)(void))animate andClickCompletion:(void (^)(BOOL nowSelect))completion ;



@end
