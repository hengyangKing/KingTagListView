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
@property(nonatomic,copy)NSArray *nowDatas;
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
-(void (^)(NSArray<YQTTagCellModel *> *))datas {
    return ^(NSArray <YQTTagCellModel *>*datas){
        if (![datas isEqualToArray:self.nowDatas]) {
            self.nowDatas  = [datas copy];
        }
    };
}
-(void (^)(TagListHeaderButtonState))headerViewClick {
    return ^(TagListHeaderButtonState needState){
        for (YQTTagView *view in self.tags) {
            if (needState == ButtonStateIsSelectAll) {
                if (view.nowState) {
                    view.clickTagView();
                }
            }else if(needState == ButtonStateIsUnSelectAll){
                if (!view.nowState) {
                    view.clickTagView();
                }
            }
        }
        if (needState == ButtonStateIsSelectAll) {
            if ([self.delegate respondsToSelector:@selector(tagListCellSelectAllTag:)]) {
                [self.delegate tagListCellSelectAllTag:self];
            }
        }else if(needState == ButtonStateIsUnSelectAll){
            if ([self.delegate respondsToSelector:@selector(tagListCellUnselectAllTag:)]) {
                [self.delegate tagListCellUnselectAllTag:self];
            }
        }
    };
}
-(void)setNowDatas:(NSArray *)nowDatas {
    _nowDatas = nowDatas;
    if (!_nowDatas.count) {
        return;
    }
    [self.tags removeAllObjects];
    for (YQTTagCellModel *model in _nowDatas) {
        if (model.title.length) {
            [self.tags addObject:[YQTTagView YQTTagWithConfig:^(YQTTagsViewConfig *config) {
                config.titleText(model.title).isSelect(model.selected);
                
            }]];
        }
    }
    [self reloadSubviews];
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
- (void)tagViewdidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    
    if ([tagView isMemberOfClass:[YQTTagView class]]) {
        YQTTagView *view = (YQTTagView *)tagView;
        if ([self.delegate respondsToSelector:@selector(tagListCell:didSelectTag:atIndex:)]) {
            view.clickTagView();
            [self.delegate tagListCell:self didSelectTag:view atIndex:index];
        }
        self.selectTag(view);
    }
}
///将要选中某tagview调用 需要在实现时调用父类的delegate
- (BOOL)tagViewShouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
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
