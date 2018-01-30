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
-(NSMutableArray *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

#pragma mark -- 实现父类声明方法
-(void (^)(NSArray<NSString *> *))datas {
    return ^(NSArray <NSString *>*datas){
        [self.tags removeAllObjects];
        for (NSString *str in datas) {
            if (str.length) {
                [self.tags addObject:[YQTRowTagView YQTRowTagWithConfig:^(YQTTagsViewConfig *config) {
                    config.titleText(str);
                }]];
            }
        }
        [self reloadSubviews];
    };
}
-(void (^)(TagListHeaderButtonState))headerViewClick {
    return ^(TagListHeaderButtonState needState){
        for (YQTRowTagView *view in self.tags) {
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

#pragma mark -- layoutSubview UI
///需要重新刷新UI
-(void)reloadSubviews {
    ///根据内容修改约束
    YQTTagListBaseCellModel *model = [YQTTagListBaseCellModel YQTTagListBaseCellModel];
    NSString *title = self.tags.count?@"点击划掉不用的句子":@"";
    model.headerTitle = title;
    model.datas = [self.tags copy];
    model.contentHSpacing = 0.f;
    self.layoutSubview(model);
}
#pragma mark YQTTagListBaseCellDatasource
- (NSUInteger)numberOfTagsInTag {
    return self.tags.count;
}

- (CGSize)tagSizeForTagAtIndex:(NSUInteger)index {
    YQTRowTagView *view = self.tags[index];
    return view.attrStr.rowSize;
}

- (UIView *)tagViewForIndex:(NSUInteger)index {
    YQTRowTagView *view = self.tags[index];
    return view;
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
- (BOOL)tagViewShouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(tagListCell:shouldSelectTag:atIndex:)]) {
        return [self.delegate tagListCell:self shouldSelectTag:tagView atIndex:index];
    }
    return YES;
}
///content view horizontalSpacing
- (CGFloat)contentViewHorizontalSpacing {
    return -2.f;
}
///header view button 是否显示
- (BOOL)hiddenHeaderButton {
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
