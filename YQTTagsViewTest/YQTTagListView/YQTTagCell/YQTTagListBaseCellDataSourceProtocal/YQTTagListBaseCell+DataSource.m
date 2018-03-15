//
//  YQTTagListBaseCell+DataSource.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBaseCell+DataSource.h"

@implementation YQTTagListBaseCell (DataSource)
///需要返回Size
- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index {
    return CGSizeZero;
}
///返回Count
- (NSUInteger)numberOfTagsInTag {
    return 0;
}
///返回contentView
- (UIView *)tagViewForIndex:(NSUInteger)index {
    return nil;
}

///选中某tagview调用 需要在实现时调用父类的delegate
- (void)tagViewDidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    
}
- (void)tagListViewGetNewDatas:(NSArray <YQTTagListCellModel *>*)newdatas {
    
}
- (void)tagListViewFoldOrUnfoldTags {
    
}
// optional func
///将要选中某tagview调用 需要在实现时调用父类的delegate
- (BOOL)tagViewShouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index atPoint:(CGPoint)point{
    return YES;
}
@end
