//
//  NSAttributedString+tagSize.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (tagSize)
///tag类型数据size
@property(nonatomic,assign,readonly)CGSize tagSize;
///row类型数据外部size
@property(nonatomic,assign,readonly)CGSize rowSize;

///row数据类型内部size
@property(nonatomic,assign,readonly)CGSize rowContentSize;



///题型数据Size
@property(nonatomic,assign,readonly)CGSize rectangleSize;
@end
