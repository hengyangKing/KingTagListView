//
//  YQTTagListCell.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/26.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListCell.h"

#import "YQTTagView.h"


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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //重置代理
        self.setTagsViewDelegate(self);
    }
    return self;
}

-(NSMutableArray *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

-(void (^)(NSArray<NSString *> *))datas {
    return ^(NSArray <NSString *>*datas){
        [self.tags removeAllObjects];
        for (NSString *str in datas) {
            if (str.length) {
                [self.tags addObject:[YQTTagView YQTTagWithConfig:^(YQTTagsViewConfig *config) {
                    config.titleText(str);
                }]];
            }
        }
        [self reloadSubviews];
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

#pragma mark - TTGTagCollectionViewDelegate
- (CGSize)tagCollectionView:(TTGTagCollectionView *)tagCollectionView sizeForTagAtIndex:(NSUInteger)index {
    YQTTagView *view = self.tags[index];
    return view.attrStr.tagSize;
}

- (void)tagCollectionView:(TTGTagCollectionView *)tagCollectionView didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([tagView isMemberOfClass:[YQTTagView class]]) {
        YQTTagView *view = (YQTTagView *)tagView;
        if ([self.delegate respondsToSelector:@selector(tagListCell:didSelectTag:atIndex:)]) {
            view.clickTagView();
            [self.delegate tagListCell:self didSelectTag:view atIndex:index];
        }
        self.selectTag(view);
    }
}
- (BOOL)tagCollectionView:(TTGTagCollectionView *)tagCollectionView shouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(tagListCell:shouldSelectTag:atIndex:)]&&[tagView isMemberOfClass:[YQTTagView class]]) {
        YQTTagView *view = (YQTTagView *)tagView;
        return [self.delegate tagListCell:self shouldSelectTag:view atIndex:index];
    }
    return YES;
}

#pragma mark - TTGTagCollectionViewDataSource

- (NSUInteger)numberOfTagsInTagCollectionView:(TTGTagCollectionView *)tagCollectionView {
    return self.tags.count;
}

- (UIView *)tagCollectionView:(TTGTagCollectionView *)tagCollectionView tagViewForIndex:(NSUInteger)index {
    YQTTagView *view = self.tags[index];
    return view;
}
#pragma mark -- layoutSubview UI
///需要重新刷新UI
-(void)reloadSubviews {
    ///根据内容修改约束
    NSString *title = self.tags.count?@"点击划掉不用的单词":@"";
    self.layoutSubview(title, [self.tags copy]);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
