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
@property(nonatomic,copy)NSArray *nowDatas;
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

#pragma mark -- 实现父类声明方法
-(void (^)(NSArray<YQTTagCellModel *> *))datas {
    return ^(NSArray <YQTTagCellModel *>*datas){
        if (![datas isEqualToArray:self.nowDatas]) {
            self.nowDatas = [datas copy];
        }
    };
}
-(void (^)(TagListHeaderButtonState))headerViewClick {
    return ^(TagListHeaderButtonState needState){
        for (YQTRectangleTagView *view in self.tags) {
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
            [self.tags addObject:[YQTRectangleTagView YQTRectangleTagWithConfig:^(YQTTagsViewConfig *config) {
                config.titleText(model.title).isSelect(model.selected);
                config.contentViewInset(UIEdgeInsetsMake(6, 0, 0, 6));
                config.normalBGColor([UIColor colorWithHex:@"#ECF9FF"]).selectedBGColor([UIColor colorWithHex:@"#FFFFFF"]);
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

- (void)tagViewdidSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTRectangleTagView class]]) {
        YQTRectangleTagView *view = (YQTRectangleTagView *)tagView;
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
