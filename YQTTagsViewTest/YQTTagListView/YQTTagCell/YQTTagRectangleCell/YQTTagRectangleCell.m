//
//  YQTTagRectangleCell.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagRectangleCell.h"
#import "YQTRectangleTagView.h"
#import "NSAttributedString+TagSize.h"
//遵循非正式协议
#import "YQTTagListBaseCell+DataSource.h"

@interface YQTTagRectangleCell()
@property(nonatomic,strong)NSMutableArray<YQTRectangleTagView *> *tags;
@end
@implementation YQTTagRectangleCell
+(instancetype)TagListCellWithTableView:(UITableView *)tableview {
    YQTTagRectangleCell *cell = [tableview dequeueReusableCellWithIdentifier:[self YQTTagViewCellID]];
    if (!cell) {
        cell = [[YQTTagRectangleCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[self YQTTagViewCellID]];
    }
    return cell;
}
#pragma mark -- lazy
-(NSMutableArray *)tags {
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
    model.headerTitle = title;
    model.tags = [self.tags copy];
    model.hiddenHeaderButton = YES;
    model.contentHSpacing = 0.f;
    model.contentVSpacing = 6.f;
    self.layoutSubview(model);

}

#pragma mark YQTTagListBaseCellDatasource

- (NSUInteger)numberOfTagsInTag {
    return self.tags.count;
}

- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index {
    YQTRectangleTagView *view = self.tags[index];
    return view.attrTitle.rectangleSize;
}

- (UIView *)tagViewForIndex:(NSUInteger)index {
    YQTRectangleTagView *view = self.tags[index];
    return view;
}

- (void)tagViewDidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTRectangleTagView class]]) {
        YQTRectangleTagView *view = (YQTRectangleTagView *)tagView;
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
            [self.tags addObject:[YQTRectangleTagView YQTRectangleTagWithConfig:^(YQTTagsViewConfig *config) {
                config.normalTitle(model.title).selectTitle(model.title);
                config.contentViewInset(UIEdgeInsetsMake(6, 0, 0, 6));
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
