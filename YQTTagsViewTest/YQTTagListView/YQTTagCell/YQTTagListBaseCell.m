//
//  YQTTagListBaseCell.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBaseCell.h"
#import "YQTTagListHeaderView.h"
#import "YQTTagBaseView.h"
#import "YQTTagListFlexButton.h"
#import "YQTTagListBaseCell+DataSource.h"//声明非正式协议

#define IOS7 kIOS7
#define     kIOS7  [[UIDevice currentDevice].systemVersion doubleValue] < 8.0 && \
[[UIDevice currentDevice].systemVersion doubleValue] >= 7.0

//收缩
#define FoldTitle @"收起"

@interface YQTTagListBaseCell()<TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource> {
    YQTTagListCellDataModel *_dataModel;
}

@property(nonatomic,strong)TTGTagCollectionView *taglistView;
@property(nonatomic,strong)YQTTagListHeaderView *header;
@property(nonatomic,strong)YQTTagListFlexButton *unfoldButton;

@property(nonatomic,strong)NSMutableArray<YQTTagBaseView *> *tags;
@property(nonatomic,strong)NSMutableArray<YQTTagBaseView *> *selectedTags;

@end
@implementation YQTTagListBaseCell
+(NSString *)YQTTagViewCellID {
    return [NSStringFromClass([self class]) stringByAppendingString:@"ID"];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    if (IOS7) {
        self.contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    }

    __weak typeof(self) weakself = self;
    [self.contentView addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.contentView);
        make.leading.mas_equalTo(weakself.contentView).mas_offset(ListTagPadding);
        make.trailing.mas_equalTo(weakself.contentView).mas_offset(-ListTagPadding);
        make.height.mas_equalTo(0);
    }];
    
#pragma mark --add unfoldButton
    [self.contentView addSubview:self.unfoldButton];
    [self.unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0).priority(999);
        make.leading.trailing.mas_equalTo(weakself.header);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom);
    }];
    
    
    [self.contentView addSubview:self.taglistView];
    [self.taglistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.mas_equalTo(weakself.header.mas_leading).mas_offset(-TagListContentInset);
        make.trailing.mas_equalTo(weakself.header.mas_trailing).mas_offset(TagListContentInset);
        make.top.mas_equalTo(weakself.header.mas_bottom).mas_offset(0.f);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom);
        
#pragma mark ---unfoldButton
        make.bottom.mas_equalTo(weakself.unfoldButton.mas_top);
    }];
}

#pragma mark lazy
-(TTGTagCollectionView *)taglistView {
    if (!_taglistView) {
        _taglistView = [[TTGTagCollectionView alloc]initWithFrame:CGRectZero];
        _taglistView.verticalSpacing = 14.f;
        _taglistView.horizontalSpacing = 14.f;
        _taglistView.delegate = self;
        _taglistView.dataSource = self;
        _taglistView.contentInset = UIEdgeInsetsMake(TagListContentInset, TagListContentInset, TagListContentInset, TagListContentInset);
        _taglistView.numberOfLines = 0;
        [_taglistView.scrollView setScrollEnabled:NO];
    }
    return _taglistView;
}
-(YQTTagListHeaderView *)header {
    if (!_header) {
        __weak typeof(self) weakself = self;
        _header = [YQTTagListHeaderView TagListHeaderViewWith:^(YQTTagListHeaderConfig *config) {
            config.needHiddenButton(NO);
            config.radius(TagListHeaderH/2.0f);
            
        } andButtonClick:^(TagListHeaderButtonState nowState) {
            [weakself headerViewButtonClick:nowState];
        }];
    }
    return _header;
}
-(YQTTagListFlexButton *)unfoldButton {
    if (!_unfoldButton) {
        _unfoldButton = [YQTTagListFlexButton createCustomButtonWithConfig:^(YQTButtonAppearanceConfig *config) {
            config.selectTitle(FoldTitle);
            config.titleFont(14);
            config.YQTButtonSEL(@selector(unfoldButtonClick:)).YQTButtonTarget(self);
            config.YQTButtonNormalImage([UIImage hyb_imageWithColor:[UIColor redColor] toSize:CGSizeMake(12, 7) cornerRadius:0]);
        }];
        _unfoldButton.hidden = YES;
    }
    return _unfoldButton;
}

-(NSMutableArray<YQTTagBaseView *> *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
-(NSMutableArray<YQTTagBaseView *> *)selectedTags {
    if (!_selectedTags) {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}
-(void (^)(YQTTagListCellDataModel *))tagListCellDataModel {
    return ^(YQTTagListCellDataModel *dataModel){
        self.dataModel = dataModel;
    };
}
-(NSArray<NSDictionary *> *)currentSelectedTags {
    NSMutableArray *temp = [NSMutableArray array];
    [self.selectedTags enumerateObjectsUsingBlock:^(YQTTagBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:[NSNumber numberWithInteger:[self.tags indexOfObject:obj]] forKey:@"index"];
        [dic setObject:obj forKey:@"tagview"];
        [temp addObject:dic];
    }];
    return [temp copy];
}

#pragma mark -- set
-(void)setDataModel:(YQTTagListCellDataModel *)dataModel {
    if (![dataModel.datas isEqualToArray:_dataModel.datas]) {
        //更新数据源
        _dataModel = dataModel;
        [self tagListViewGetNewDatas:_dataModel.datas];
    }else if (_dataModel.appearModel.needRefashion){
        //需要展开或者收缩列表
        _dataModel.appearModel.needRefashion = NO;
        [self tagListViewFoldOrUnfoldTags];
    }
}
#pragma mark -- 父类子类通信
-(void (^)(UIView *))selectTag {
    return ^(UIView *v){
        if ([v isKindOfClass:[YQTTagBaseView class]]) {
            YQTTagBaseView *view = (YQTTagBaseView *)v;
            @synchronized (self){
                if ([self.selectedTags containsObject:view]) {
                    //包含 反选
                    [self.selectedTags removeObject:view];
                }else{
                    //不包含
                    [self.selectedTags addObject:view];
                }
                [self updateHeaderBarState];
            }
        }
    };
}

-(void (^)(YQTTagListBaseCellModel *))layoutSubview {
    return ^(YQTTagListBaseCellModel *model){
        self.header.headerTitle(model.headerTitle);
        [self.tags removeAllObjects];
        [self.tags addObjectsFromArray:[model.tags copy]];
        [self.selectedTags removeAllObjects];
        self.taglistView.horizontalSpacing = model.contentHSpacing;
        self.taglistView.verticalSpacing = model.contentVSpacing;
        self.taglistView.numberOfLines = 0;
        self.header.hiddenHeaderButton(model.hiddenHeaderButton);
        __weak typeof(self) weakself = self;
        //刷新UI
        [self.header mas_remakeConstraints:^(MASConstraintMaker *make) {
            //1偏移 解决导航栏线 有1像素偏移
            make.top.mas_equalTo(weakself.contentView.mas_top).mas_offset(1);
            make.leading.mas_equalTo(weakself.contentView).mas_offset(model.contentViewMargin);
            make.trailing.mas_equalTo(weakself.contentView).mas_offset(-model.contentViewMargin);
                make.height.mas_equalTo(TagListHeaderH);
            
        }];
        [self.taglistView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(weakself.header.mas_leading).mas_offset(-TagListContentInset);
            make.trailing.mas_equalTo(weakself.header.mas_trailing).mas_offset(TagListContentInset);
            make.top.mas_equalTo(weakself.header.mas_bottom).mas_offset(15.f);
            make.bottom.mas_equalTo(weakself.unfoldButton.mas_top);

        }];
        [self.tags enumerateObjectsUsingBlock:^(YQTTagBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ///初始化时已经被选中的数据源
            if (obj.selected) {
                weakself.selectTag(obj);
            }
        }];
        [self updateHeaderBarState];
        [self.taglistView reload];
        
        //更新折叠状态
        if (!self.dataModel.appearModel.numberOfLines) {
            //不具备收缩功能
            self.dataModel.appearModel.canFlex = NO;
            self.dataModel.appearModel.TagListCellAppearanceState(CellNowFlexStateIsUnflex);//当前展开
            return ;
        }
        ///收缩
        if ((self.dataModel.appearModel.nowState == CellNowFlexStateIsFlex)&&self.dataModel.appearModel.canFlex) {
            //需要收缩
            if (self.taglistView.actualNumberOfLines <= self.dataModel.appearModel.numberOfLines) {
                //实际行数小于等于目标行数
                self.dataModel.appearModel.canFlex = NO;
                self.dataModel.appearModel.TagListCellAppearanceState(CellNowFlexStateIsUnflex);

            }else{
                //实际行数大于目标行数
                self.dataModel.appearModel.canFlex = YES;
                self.taglistView.numberOfLines = self.dataModel.appearModel.numberOfLines;
                self.dataModel.appearModel.TagListCellAppearanceState(CellNowFlexStateIsFlex);
                self.unfoldButton.YQTTagListCustomButtonNormalTitle(model.unfoldTitle);
                [self.unfoldButton setHidden:NO];
                [self.taglistView reload];
            }
        }
    };
}
///header 选择 刷新子类状态
-(void)headerViewButtonClick:(TagListHeaderButtonState )nowTitleState {
    //刷新UI
    [self.tags enumerateObjectsUsingBlock:^(YQTTagBaseView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (nowTitleState == ButtonStateIsSelectAll && (!view.selected)) {
            view.clickTagView();
        }else if(nowTitleState == ButtonStateIsUnSelectAll && view.selected){
            view.clickTagView();
        }
    }];
    
    if (nowTitleState == ButtonStateIsSelectAll) {
        if ([self.delegate respondsToSelector:@selector(tagListCellSelectAllTag:)]) {
            [self.delegate tagListCellSelectAllTag:self];
        }
    }else if(nowTitleState == ButtonStateIsUnSelectAll){
        if ([self.delegate respondsToSelector:@selector(tagListCellUnselectAllTag:)]) {
            [self.delegate tagListCellUnselectAllTag:self];
        }
    }
    
    [self.selectedTags removeAllObjects];
    if (nowTitleState == ButtonStateIsSelectAll) {
        [self.selectedTags addObjectsFromArray:self.tags];
    }
    
}
///更新HeaderBar state
-(void)updateHeaderBarState{
    if (!self.selectedTags.count) {
        //没有一个选中 需要全选
        self.header.changeBtnState(ButtonStateIsSelectAll);
    }
    if (self.selectedTags.count == self.tags.count) {
        //数量相同 取消全选
        self.header.changeBtnState(ButtonStateIsUnSelectAll);
    }else{
        //数量不相同 全选
        self.header.changeBtnState(ButtonStateIsSelectAll);
    }
}
#pragma mark - TTGTagCollectionViewDelegate 需子类遵循父类非正式协议数据源
- (CGSize)tagCollectionView:(TTGTagCollectionView *)tagCollectionView sizeForTagAtIndex:(NSUInteger)index {
    return [self tagSizeForTagAtIndex:index];
}
- (void)tagCollectionView:(TTGTagCollectionView *)tagCollectionView didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    [self tagViewDidSelectTag:tagView atIndex:index];
}
- (BOOL)tagCollectionView:(TTGTagCollectionView *)tagCollectionView shouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index atPoint:(CGPoint)point{
    if ([self respondsToSelector:@selector(tagViewShouldSelectTag:atIndex: atPoint:)]) {
        return [self tagViewShouldSelectTag:tagView atIndex:index atPoint:point];
    }
    return YES;
}

#pragma mark -- TTGTagCollectionViewDataSource

- (NSUInteger)numberOfTagsInTagCollectionView:(TTGTagCollectionView *)tagCollectionView {
    return [self numberOfTagsInTag];
}

- (UIView *)tagCollectionView:(TTGTagCollectionView *)tagCollectionView tagViewForIndex:(NSUInteger)index {
    return [self tagViewForIndex:index];
}

#pragma mark -- func
-(void)unfoldButtonClick:(YQTTagListFlexButton *)button {
    
    //展开时需要判断是否具有收缩功能，收缩时展示
    [self.unfoldButton setHidden: button.selected ? NO :(!self.dataModel.appearModel.canDrawBack)];
    button.selected = !button.selected;
    
    self.dataModel.appearModel.needRefashion = YES;
    UIView *view = self.superview;
    while ((![view isKindOfClass:[UITableView class]]) && view) {
        view = view.superview;
    }
    UITableView *tableview = (UITableView *)view;
    [tableview reloadData];
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableview scrollToRowAtIndexPath:[tableview indexPathForCell:weakself] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    });
    self.dataModel.appearModel.TagListCellAppearanceState(button.selected?CellNowFlexStateIsUnflex:CellNowFlexStateIsFlex);
}

/**
 将当前cell 内 所有tag 全部取消选中
 */
-(void)unSelectTags {
    [self headerViewButtonClick:(ButtonStateIsUnSelectAll)];
    [self updateHeaderBarState];
}

/**
 将当前cell 内 所有tag 全部选中
 */
-(void)selectTags {
    [self headerViewButtonClick:(ButtonStateIsSelectAll)];
    [self updateHeaderBarState];
}

@end
