//
//  YQTTagZoomButton.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/27.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagZoomButton.h"
#import "Masonry.h"
@interface YQTTagZoomButton()
@property(nonatomic,assign)CGSize buttonSize;
@property(nonatomic,assign)BOOL zoom;
@property(nonatomic,copy)void (^completionBlock)(BOOL nowSelect);
@property(nonatomic,copy)CGFloat (^animateBlock)(void);
@end
@implementation YQTTagZoomButton

+(instancetype)zoomButtonAnimateWidth:(CGFloat (^)(void))animate andClickCompletion:(void (^)(BOOL nowSelect))completion {    YQTTagZoomButton *button = [YQTTagZoomButton buttonWithType:UIButtonTypeCustom];
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
-(void)buttonClick {
    !self.completionBlock?:self.completionBlock(self.selected);
}

-(void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    //动画执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat width = (!self.animateBlock)?self.frame.size.width:self.animateBlock();
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
        [self.superview setNeedsUpdateConstraints];
        [self.superview updateConstraintsIfNeeded];
        
        [UIView animateWithDuration:.3f animations:^{
            [self.superview layoutIfNeeded];
        } completion:nil];
    });
}



@end
