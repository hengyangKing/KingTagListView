//
//  YQTTagListFlexButton.m
//  YQTTagsViewTest
//
//  Created by 17zuoye on 2018/3/19.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListFlexButton.h"

@implementation YQTTagListFlexButton

-(void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (self.superview) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hidden?0:TagListFootH).priority(999);
        }];
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = 16.f - ([self titleLabel].frame.size.height / 2.0);
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter ;
    
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = CGRectGetMaxY(self.titleLabel.frame)+(self.imageView.frame.size.height/2.0) + 6.0f;
    self.imageView.center = center;
}
@end
