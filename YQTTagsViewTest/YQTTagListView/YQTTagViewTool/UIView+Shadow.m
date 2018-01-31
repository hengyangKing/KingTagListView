//
//  UIView+Shadow.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "UIView+Shadow.h"
#import <objc/runtime.h>

@interface UIView()
@property(nonatomic,strong)UIView *shadowContainer;
@end
@implementation UIView (Shadow)
-(void)addShadowWithColor:(UIColor *)color Radius:(CGFloat)radius {
#pragma mark 效率问题 暂时不加阴影
    return;
    if (self.shadowContainer != nil) {
        [self.shadowContainer removeFromSuperview];
    }
    self.shadowContainer = [[UIView alloc] initWithFrame: self.frame];

//    [self.shadowContainer mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.left.right.mas_equalTo(self);
//    }];
    self.shadowContainer.backgroundColor = [UIColor whiteColor];
    // Setup shadow layer and corner
    self.shadowContainer.layer.shadowColor = color.CGColor;
    self.shadowContainer.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowContainer.layer.shadowRadius = radius;
    self.shadowContainer.layer.shadowOpacity = 1;
    self.shadowContainer.layer.cornerRadius = self.layer.cornerRadius;
    self.shadowContainer.clipsToBounds = NO;
    // Add shadow container to super view.
    [self.superview insertSubview:self.shadowContainer atIndex:0];
    // Add layout constraint for shadow container.
    [self equalToImageViewConstraintFor:self.shadowContainer];
    
}
-(void)showShadow {
    self.shadowContainer.hidden=NO;
}
-(void)hiddenShadow {
    self.shadowContainer.hidden=YES;
}
#pragma mark - Properties
- (UIView *)shadowContainer {
    return objc_getAssociatedObject(self, @selector(shadowContainer));
}

- (void)setShadowContainer:(UIView *)shadowContainer {
    if (self.shadowContainer != shadowContainer) {
        objc_setAssociatedObject(self, @selector(shadowContainer), shadowContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - Service
// Set constraint for a view, this view's position and size will be same with image view(self).
- (void)equalToImageViewConstraintFor:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.superview addConstraints:[NSArray arrayWithObjects:
                                    [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:0],
                                    [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:view
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1
                                                                  constant:0],
                                    [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:view
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1
                                                                  constant:0],
                                    [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:view
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:0],
                                    nil]];
}
@end
