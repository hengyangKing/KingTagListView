//
//  YQTTagListHeaderView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagListHeaderConfig.h"
@interface YQTTagListHeaderView : UIView

+(instancetype)TagListHeaderViewWith:(void (^)(YQTTagListHeaderConfig *config))config andButtonClick:(void (^)(TagListHeaderButtonState state))buttonClick;

///需要改变button 状态时调用
@property(nonatomic,copy,readonly)void (^changeBtnState)(TagListHeaderButtonState state);
///设置Headertitle
@property(nonatomic,copy,readonly)void (^headerTitle)(NSString *title);
///设置header button
@property(nonatomic,copy,readonly)void (^hiddenHeaderButton)(BOOL hidden);

@property(nonatomic,assign,readonly)TagListHeaderButtonState currentState;

@end
