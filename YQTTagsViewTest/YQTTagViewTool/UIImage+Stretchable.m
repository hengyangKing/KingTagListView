//
//  UIImage+Stretchable.m
//  YQTTagsViewTest
//
//  Created by J on 2018/2/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "UIImage+Stretchable.h"

@implementation UIImage (Stretchable)
-(UIImage *)stretchableImage {
    return [self stretchableWithLeftCap:0.5 topCap:0.5];
}

-(UIImage *)stretchableWithLeftCap:(CGFloat)leftCap topCap:(CGFloat)topCap {
    return [self stretchableImageWithLeftCapWidth:self.size.width * leftCap topCapHeight:self.size.height * topCap];
}

@end
