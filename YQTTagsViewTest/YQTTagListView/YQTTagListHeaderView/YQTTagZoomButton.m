//
//  YQTTagZoomButton.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/27.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagZoomButton.h"
#import "Masonry.h"
@interface YQTTagZoomButton() {
    BOOL _animateing;
}
@property(nonatomic,assign)CGSize buttonSize;
@property(nonatomic,assign)BOOL zoom;
@property(nonatomic,copy)void (^completionBlock)(BOOL nowSelect);
@property(nonatomic,copy)CGFloat (^animateBlock)(void);

///用户行为列表
@property(nonatomic,strong)NSMutableArray<NSNumber *> *userActions;

@end
@implementation YQTTagZoomButton

+(instancetype)zoomButtonAnimateWidth:(CGFloat (^)(void))animate andClickCompletion:(void (^)(BOOL nowSelect))completion {
    YQTTagZoomButton *button = [YQTTagZoomButton buttonWithType:UIButtonTypeCustom];
    [button setAnimateBlock:animate];
    [button setCompletionBlock:completion];
    return button;
}
+(instancetype)buttonWithType:(UIButtonType)buttonType {
    YQTTagZoomButton *button = [super buttonWithType:buttonType];
    if (button) {
        [button addTarget:button action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return button;
}
-(NSMutableArray<NSNumber *> *)userActions {
    if (!_userActions) {
        _userActions = [NSMutableArray array];
    }
    return _userActions;
}
-(void)buttonClick {
    !self.completionBlock?:self.completionBlock(self.selected);
}
-(void)setSelected:(BOOL)selected {
    if (_animateing) {
        return;
    }
    [super setSelected:selected];
    //动画执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _animateing = YES;
        CGFloat width = (!self.animateBlock)?self.frame.size.width:self.animateBlock();
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
        [self.superview setNeedsUpdateConstraints];
        [self.superview updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:.3f animations:^{
            [self.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            _animateing = NO;
            [self fixButtonState];
        }];
    });
}
///外界调用改变button 状态
-(void)changeButtonState:(BOOL)selelcted {
    if (_animateing) {
        [self.userActions addObject:[NSNumber numberWithBool:selelcted]];
    }else{
        self.selected = selelcted;
    }
}
///每次动画执行完成 需要检查用户最后一次行为
-(void)fixButtonState {
    if (!self.userActions.count) {
        return;
    }
    if (!_animateing) {
        [self setSelected:self.userActions.lastObject.boolValue];
        [self.userActions removeAllObjects];
    }
}
-(void)setHighlighted:(BOOL)highlighted {
    
}


@end
