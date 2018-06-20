//
//  YQTTagMultiLineRectangleCell.m
//  YQTTagsViewTest
//
//  Created by king on 2018/6/20.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagMultiLineRectangleCell.h"
#import "YQTMultiLineRectangleTagView.h"
#import "NSAttributedString+TagSize.h"
//遵循非正式协议
#import "YQTTagListBaseCell+DataSource.h"
@interface YQTTagMultiLineRectangleCell()
@property(nonatomic,strong)NSMutableArray<YQTMultiLineRectangleTagView *> *tags;

@end
@implementation YQTTagMultiLineRectangleCell
+(instancetype)TagListCellWithTableView:(UITableView *)tableview {
    YQTTagMultiLineRectangleCell *cell = [tableview dequeueReusableCellWithIdentifier:[self YQTTagViewCellID]];
    if (!cell) {
        cell = [[YQTTagMultiLineRectangleCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[self YQTTagViewCellID]];
    }
    return cell;
}
-(NSMutableArray<YQTMultiLineRectangleTagView *> *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
#pragma mark -- layoutSubview UI
///需要重新刷新UI
-(void)reloadSubviews {
    
    ///根据内容修改约束
    YQTTagListBaseCellModel *model = [YQTTagListBaseCellModel YQTTagListBaseCellModel];
    
    ///根据内容修改约束
    NSString *title = self.tags.count?@"选择题型":@"";
    model.headerTitle = self.dataModel.appearModel.title.length?self.dataModel.appearModel.title:title;
    model.tags = [self.tags copy];
    model.hiddenHeaderButton = YES;
    model.contentVSpacing = 10.f;
    model.contentViewMargin = 20.f;
    self.layoutSubview(model);
    
}

#pragma mark YQTTagListBaseCellDatasource
- (NSUInteger)numberOfTagsInTag {
    return self.tags.count;
}

- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index {
    YQTMultiLineRectangleTagView *view = self.tags[index];
    return view.attrTitle.multiLineRectangleSize;
}

- (UIView *)tagViewForIndex:(NSUInteger)index {
    YQTMultiLineRectangleTagView *view = self.tags[index];
    return view;
}

- (void)tagViewDidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTMultiLineRectangleTagView class]]) {
        YQTMultiLineRectangleTagView *view = (YQTMultiLineRectangleTagView *)tagView;
        if ([self.delegate respondsToSelector:@selector(tagListCell:didSelectTag:atIndex:)]) {
            view.clickTagView();
            [self.delegate tagListCell:self didSelectTag:view atIndex:index];
        }
        self.selectTag(view);
    }
}
-(void)tagListViewGetNewDatas:(NSArray<YQTTagListCellModel *> *)newdatas {
    
    if (!newdatas.count) {return;}
    [self.tags removeAllObjects];
    [newdatas enumerateObjectsUsingBlock:^(YQTTagListCellModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.title.length) {
            [self.tags addObject:[YQTMultiLineRectangleTagView YQTMultiLineRectangleTagWithConfig:^(YQTTagsViewConfig *config) {
                config.normalTitle(model.title).selectTitle(model.title);
                config.isSelect(model.selected);
            }]];
        }
    }];
    [self reloadSubviews];
}
///折叠或收缩调用
-(void)tagListViewFoldOrUnfoldTags {
    [self reloadSubviews];
}
///将要选中某tagview调用 需要在实现时调用父类的delegate
- (BOOL)tagViewShouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index atPoint:(CGPoint)point{
    if ([self.delegate respondsToSelector:@selector(tagListCell:shouldSelectTag:atIndex:)]) {
        return [self.delegate tagListCell:self shouldSelectTag:tagView atIndex:index];
    }
    return YES;
}


@end
