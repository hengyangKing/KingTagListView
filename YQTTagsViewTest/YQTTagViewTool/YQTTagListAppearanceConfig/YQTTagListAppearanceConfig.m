//
//  YQTTagListAppearanceConfig.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/13.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListAppearanceConfig.h"

@implementation YQTTagListAppearanceConfig
-(instancetype)init {
    self = [super init];
    if (self) {
        self.borderW(1.0f);
    }
    return self;
}
-(YQTTagListAppearanceConfig *(^)(CGFloat))radius {
    return ^(CGFloat cornerRadius){
        self.cornerRadius = cornerRadius;
        return self;
    };
}
-(YQTTagListAppearanceConfig *(^)(CGFloat))borderW {
    return ^(CGFloat width){
        self.borderWidth = width;
        return self;
    };
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
}
-(void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
}
@end
