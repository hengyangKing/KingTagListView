//
//  YQTTagRowCell.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagRowCell.h"
#import "YQTRowTagView.h"
#import "NSAttributedString+TagSize.h"
//遵循非正式协议
#import "YQTTagListBaseCell+DataSource.h"
#define KEYWORD @"句子"

@interface YQTTagRowCell()
@property(nonatomic,strong)NSMutableArray<YQTRowTagView *> *tags;
@end
@implementation YQTTagRowCell

+(instancetype)TagListCellWithTableView:(UITableView *)tableview {
    YQTTagRowCell *cell = [tableview dequeueReusableCellWithIdentifier:[self YQTTagViewCellID]];
    if (!cell) {
        cell = [[YQTTagRowCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[self YQTTagViewCellID]];
    }
    return cell;
}

#pragma mark -- lazy
-(NSMutableArray<YQTRowTagView *> *)tags {
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
    
    NSString *title = self.tags.count?HeaderTitlt(KEYWORD):@"";
    model.unfoldTitle = UnfoldTitle(self.tags.count, KEYWORD);
    model.headerTitle = self.dataModel.appearModel.title.length?self.dataModel.appearModel.title:title;
    model.tags = [self.tags copy];
    model.contentHSpacing = 0.f;
    self.layoutSubview(model);
}
#pragma mark YQTTagListBaseCellDatasource
- (NSUInteger)numberOfTagsInTag {
    return self.tags.count;
}

- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index {
    YQTRowTagView *view = self.tags[index];
    return view.attrTitle.rowSize;
}

- (UIView *)tagViewForIndex:(NSUInteger)index {
    return self.tags[index];
}
- (void)tagViewDidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTRowTagView class]]) {
        YQTRowTagView *view = (YQTRowTagView *)tagView;
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
            [self.tags addObject:[YQTRowTagView YQTRowTagWithConfig:^(YQTTagsViewConfig *config) {
                config.normalTitle(model.title).selectTitle(model.title);
                config.isSelect(model.selected);
            }]];
        }
    }];
    [self reloadSubviews];
}
///折叠或者收缩调用
-(void)tagListViewFoldOrUnfoldTags {
    [self reloadSubviews];
}

///将要选中某tagview调用 需要在实现时调用父类的delegate
- (BOOL)tagViewShouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index atPoint:(CGPoint)point{
    
    if ([tagView isKindOfClass:[YQTRowTagView class]]) {
        YQTRowTagView *view = (YQTRowTagView *)tagView;
        if (CGRectContainsPoint(view.bgImage.frame, point)) {
            if ([self.delegate respondsToSelector:@selector(tagListCell:shouldSelectTag:atIndex:)]) {
                return [self.delegate tagListCell:self shouldSelectTag:tagView atIndex:index];
            }
            //默认在 bgImage 上可点击
            return YES;
        }
    }
    //默认不在 bgImage 上可点击
    return NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
