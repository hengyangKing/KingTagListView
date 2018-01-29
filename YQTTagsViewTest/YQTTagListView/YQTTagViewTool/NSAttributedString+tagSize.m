//
//  NSAttributedString+tagSize.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "NSAttributedString+tagSize.h"
#import "YQTTagListCommon.h"
//tag maxsize
#define MAXSIZE CGSizeMake([UIScreen mainScreen].bounds.size.width-(2*ListTagPadding), MAXFLOAT)

@implementation NSAttributedString (tagSize)
-(CGSize)tagSize {
    
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    CGSize contentSize = [attr boundingRectWithSize:MAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    contentSize.width += ((13*2)+4);
    contentSize.height += (8.5*2);
    return contentSize;
}

-(CGSize)rowSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    CGSize contentSize = [attr boundingRectWithSize:MAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    NSRange range = NSMakeRange(0, 1);
    NSAttributedString *oneRowAttr = [[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]];
    
    CGSize oneRowSize = [oneRowAttr boundingRectWithSize:MAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    CGFloat width = MAXSIZE.width;
    width -= (13*2)+4;
    
    if (contentSize.height > oneRowSize.height) {
        //多行
        CGFloat hight = contentSize.height;
        hight += (8.5*2);
        return CGSizeMake(width, hight);
    }
    //单行
    contentSize.height += (8.5*2);
    return CGSizeMake(width, contentSize.height);
}
-(CGSize)rowContentSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    CGSize contentSize = [attr boundingRectWithSize:MAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

    NSRange range = NSMakeRange(0, 1);
    NSAttributedString *oneRowAttr = [[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]];
    
    CGSize oneRowSize = [oneRowAttr boundingRectWithSize:MAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    if (contentSize.height > oneRowSize.height) {
        //多行
        CGFloat hight = contentSize.height;
        hight += (8.5*2);
        CGFloat width = MAXSIZE.width;        
        return CGSizeMake(width, hight);
    }
    //单行
    contentSize.width += ((13*2)+4);
    contentSize.height += (8.5*2);
    return contentSize;
}
-(CGSize)rectangleSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    
    CGFloat padding = 6.f;//预留半透明部分
    CGFloat scale = (168.f+padding)/(46.f+padding);
    CGFloat W = (((MAXSIZE.width)/2.0f)-2.f);
    CGFloat scaleH = W/scale;
    return  CGSizeMake(W, scaleH);
}

@end
