//
//  YQTTagListCell.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListCell.h"
#import "YQTTagView.h"
#import "NSAttributedString+TagSize.h"
//遵循非正式协议
#import "YQTTagListBaseCell+DataSource.h"
@interface YQTTagListCell()
@property(nonatomic,strong)NSMutableArray<YQTTagView *> *tags;
@end
@implementation YQTTagListCell
+(instancetype)TagListCellWithTableView:(UITableView *)tableview {
    YQTTagListCell *cell = [tableview dequeueReusableCellWithIdentifier:[self YQTTagViewCellID]];
    if (!cell) {
        cell = [[YQTTagListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[self YQTTagViewCellID]];
    }
    return cell;
}
-(NSMutableArray *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
#pragma mark - YQTTagListBaseCellDataSource
- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index {
    YQTTagView *view = self.tags[index];
    return view.attrTitle.tagSize;
}
///返回Count
- (NSUInteger)numberOfTagsInTag {
    return self.tags.count;    
}
///返回contentView
- (UIView *)tagViewForIndex:(NSUInteger)index {
    YQTTagView *view = self.tags[index];
    return view;
}
///选中某tagview调用 需要在实现时调用父类的delegate
- (void)tagViewDidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTTagView class]]) {
        YQTTagView *view = (YQTTagView *)tagView;
        if ([self.delegate respondsToSelector:@selector(tagListCell:didSelectTag:atIndex:)]) {
            view.clickTagView();
            [self.delegate tagListCell:self didSelectTag:view atIndex:index];
        }
        self.selectTag(view);
    }
}
///更新数据源
-(void)tagListViewGetNewDatas:(NSArray<YQTTagListCellModel *> *)newdatas {
    if (!newdatas.count) {return;}
    [self.tags removeAllObjects];
    [newdatas enumerateObjectsUsingBlock:^(YQTTagListCellModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.title.length) {
            [self.tags addObject:[YQTTagView YQTTagWithConfig:^(YQTTagsViewConfig *config) {
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
#pragma mark -- layoutSubview UI
///需要重新刷新UI
-(void)reloadSubviews {
    ///根据内容修改约束
    YQTTagListBaseCellModel *model = [YQTTagListBaseCellModel YQTTagListBaseCellModel];
    
    NSString *title = self.tags.count?@"点击划掉不用的单词":@"";
    model.headerTitle = title;
    model.tags = [self.tags copy];
    self.layoutSubview(model);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
