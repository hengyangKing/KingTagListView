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

@interface YQTTagRowCell()
@property(nonatomic,strong)NSMutableArray<YQTRowTagView *> *tags;
@property(nonatomic,copy)NSArray *nowDatas;
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

#pragma mark -- 实现父类声明方法
-(void (^)(NSArray<YQTTagListCellModel *> *))datas {
    return ^(NSArray <YQTTagListCellModel *>*datas){
        if (![datas isEqualToArray:self.nowDatas]) {
            self.nowDatas = [datas copy];
        }
    };
}
-(void)setNowDatas:(NSArray *)nowDatas {
    _nowDatas = nowDatas;
    if (!_nowDatas.count) {
        return;
    }
    [self.tags removeAllObjects];
    for (YQTTagListCellModel *model in _nowDatas) {
        if (model.title.length) {
            [self.tags addObject:[YQTRowTagView YQTRowTagWithConfig:^(YQTTagsViewConfig *config) {
                config.titleText(model.title).isSelect(model.selected);
            }]];
        }
    }
    [self reloadSubviews];
    
}
#pragma mark -- layoutSubview UI
///需要重新刷新UI
-(void)reloadSubviews {
    ///根据内容修改约束
    YQTTagListBaseCellModel *model = [YQTTagListBaseCellModel YQTTagListBaseCellModel];
    NSString *title = self.tags.count?@"点击划掉不用的句子":@"";
    model.headerTitle = title;
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

- (void)tagViewdidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTRowTagView class]]) {
        YQTRowTagView *view = (YQTRowTagView *)tagView;
        if ([self.delegate respondsToSelector:@selector(tagListCell:didSelectTag:atIndex:)]) {
            view.clickTagView();
            [self.delegate tagListCell:self didSelectTag:view atIndex:index];
        }
        self.selectTag(view);
    }
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