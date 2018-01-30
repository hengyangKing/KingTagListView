//
//  YQTTagListBaseCell+DataSource.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBaseCell.h"
///YQTTagListBaseCell 数据源非正式协议协议 子类必须实现

@interface YQTTagListBaseCell (DataSource)
///需要返回Size
- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index;
///返回Count
- (NSUInteger)numberOfTagsInTag;
///返回contentView
- (UIView *)tagViewForIndex:(NSUInteger)index;

///选中某tagview调用 需要在实现时调用父类的delegate
- (void)tagViewdidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index;

// optional func
///将要选中某tagview调用 需要在实现时调用父类的delegate
- (BOOL)tagViewShouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index;

@end
