//
//  NSAttributedString+tagSize.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "NSAttributedString+TagSize.h"
#import "YQTTagListCommon.h"
//tag maxsize
#define MAXCONTENTSIZE CGSizeMake([UIScreen mainScreen].bounds.size.width-(2*ListTagPadding), MAXFLOAT)

#define CONTENTINSET 2*TagListContentInset

#define TAGMAXSIZE CGSizeMake(MAXCONTENTSIZE.width-(2*ListTagPadding) - CONTENTINSET, MAXCONTENTSIZE.height)

@implementation NSAttributedString (TagSize)
-(CGSize)tagSize {
    
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    CGSize size = TAGMAXSIZE;
    CGSize contentSize = [attr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    contentSize.width += ((ListTagPadding*2)+1);//左右
    contentSize.height += (ListTagMargin*2);

    return contentSize;
}

-(CGSize)rowSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    
    CGSize contentSize = [attr boundingRectWithSize:TAGMAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    contentSize.height += (ListTagMargin*2);
    return CGSizeMake(MAXCONTENTSIZE.width-CONTENTINSET, contentSize.height);
}
-(CGSize)rowContentSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }

    CGSize contentSize = [attr boundingRectWithSize:TAGMAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

    NSRange range = NSMakeRange(0, attr.length);
    NSAttributedString *oneRowAttr = [[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:0 effectiveRange:&range]];
    
    CGSize oneRowSize = [oneRowAttr boundingRectWithSize:TAGMAXSIZE options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    if (contentSize.height > oneRowSize.height) {
        //多行
        CGFloat hight = contentSize.height;
        hight += (ListTagMargin*2);
        return CGSizeMake(MAXCONTENTSIZE.width-CONTENTINSET, hight);
    }
    //单行
    contentSize.width += ((ListTagPadding*2)+2);
    contentSize.height += (ListTagMargin*2);
    return contentSize;
}
-(CGSize)rectangleSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    
    CGFloat padding = 6.f;//预留半透明部分
    CGFloat scale = (168.f+padding)/(46.f+padding);
    CGFloat W = (((MAXCONTENTSIZE.width)/2.0f)-2.f);
    CGFloat scaleH = W/scale;
    return  CGSizeMake(W, scaleH);
}
- (CGSize)multiLineRectangleSize {
    NSAttributedString *attr =self;
    if (!attr.string.length) {
        return CGSizeZero;
    }
    CGFloat scale = 160.f/45.f;
    //之前 两边margin 为 15 现在为 20 so-10
    //15 为 tag 间距
    CGFloat W = (((MAXCONTENTSIZE.width - 10.0f - 15.f )/2.0f)-2.0f);
    CGFloat scaleH = W/scale;
    return  CGSizeMake(W, scaleH);
    
}
@end
