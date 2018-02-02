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

#import "YQTTagListBaseCell+DataSource.h"//声明非正式协议

@interface YQTTagListBaseCell()<TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource>
@property(nonatomic,strong)TTGTagCollectionView *taglistView;
@property(nonatomic,strong)YQTTagListHeaderView *header;
@property(nonatomic,strong)NSMutableArray *tags;
@property(nonatomic,strong)NSMutableArray *deleteTags;



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
    [self.contentView addSubview:self.header];
    __weak typeof(self) weakself = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.contentView);
        make.leading.mas_equalTo(weakself.contentView).mas_offset(ListTagPadding);
        make.trailing.mas_equalTo(weakself.contentView).mas_offset(-ListTagPadding);
        make.height.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:self.taglistView];
    [self.taglistView mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.mas_equalTo(weakself.header.mas_leading).mas_offset(-TagListContentInset);
    make.trailing.mas_equalTo(weakself.header.mas_trailing).mas_offset(TagListContentInset);
        make.top.mas_equalTo(weakself.header.mas_bottom).mas_offset(0.f);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom).mas_offset(0.f);
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
    }
    return _taglistView;
}
-(YQTTagListHeaderView *)header {
    if (!_header) {
        __weak typeof(self) weakself = self;
        _header = [YQTTagListHeaderView TagListHeaderViewWith:^(YQTTagListHeaderConfig *config) {
            config.needHiddenButton(NO);
            config.radius(TagListHeaderH/2.0f);
            
        } andButtonClick:^(TagListHeaderButtonState willState) {
            !weakself.headerViewClick?:weakself.headerViewClick(willState);
            [self.deleteTags removeAllObjects];
            if (willState == ButtonStateIsUnSelectAll) {
                [self.deleteTags addObjectsFromArray:self.tags];
            }
        }];
    }
    return _header;
}
-(NSMutableArray *)tags {
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
-(NSMutableArray *)deleteTags {
    if (!_deleteTags) {
        _deleteTags = [NSMutableArray array];
    }
    return _deleteTags;
}

#pragma mark -- 父类子类通信
-(void (^)(UIView *))selectTag {
    return ^(UIView *view){
        @synchronized (self){
            if ([self.deleteTags containsObject:view]) {
                //包含
                [self.deleteTags removeObject:view];
            }else{
                //不包含
                [self.deleteTags addObject:view];
            }
            if (!self.deleteTags.count) {
                //没有一个需要删除 需要全选
                self.header.changeBtnState(ButtonStateIsSelectAll);
            }
            if (self.deleteTags.count == self.tags.count) {
                //数量相同 取消全选
                self.header.changeBtnState(ButtonStateIsUnSelectAll);
            }else{
                //没有一个需要删除 需要全选
                self.header.changeBtnState(ButtonStateIsSelectAll);
            }
        }
    };
}

-(void (^)(YQTTagListBaseCellModel *))layoutSubview {
    return ^(YQTTagListBaseCellModel *model){
        self.header.headerTitle(model.headerTitle);
        [self.tags removeAllObjects];
        [self.tags addObjectsFromArray:[model.tags copy]];
        self.taglistView.horizontalSpacing = model.contentHSpacing;
        self.taglistView.verticalSpacing = model.contentVSpacing;
        self.header.hiddenHeaderButton(model.hiddenHeaderButton);
        [self.taglistView reload];

        //刷新UI
        __weak typeof(self) weakself = self;
        
        [self.header mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakself.contentView);
            make.leading.mas_equalTo(weakself.contentView).mas_offset(ListTagPadding);
            make.trailing.mas_equalTo(weakself.contentView).mas_offset(-ListTagPadding);
            make.height.mas_equalTo(TagListHeaderH);
            
        }];
        
        [self.taglistView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(weakself.header.mas_leading).mas_offset(-TagListContentInset);
            make.trailing.mas_equalTo(weakself.header.mas_trailing).mas_offset(TagListContentInset);
            make.top.mas_equalTo(weakself.header.mas_bottom).mas_offset(15.f);
            make.bottom.mas_equalTo(weakself.contentView.mas_bottom);
        }];
    };
}
#pragma mark - TTGTagCollectionViewDelegate 需子类遵循父类非正式协议数据源

- (CGSize)tagCollectionView:(TTGTagCollectionView *)tagCollectionView sizeForTagAtIndex:(NSUInteger)index {
    
    return [self tagSizeForTagAtIndex:index];
}
- (void)tagCollectionView:(TTGTagCollectionView *)tagCollectionView didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    [self tagViewdidSelectTag:tagView atIndex:index];
}
- (BOOL)tagCollectionView:(TTGTagCollectionView *)tagCollectionView shouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if ([self respondsToSelector:@selector(tagViewShouldSelectTag:atIndex:)]) {
        return [self tagViewShouldSelectTag:tagView atIndex:index];
    }
    return YES;
}

#pragma mark - TTGTagCollectionViewDataSource

- (NSUInteger)numberOfTagsInTagCollectionView:(TTGTagCollectionView *)tagCollectionView {
    return [self numberOfTagsInTag];
}

- (UIView *)tagCollectionView:(TTGTagCollectionView *)tagCollectionView tagViewForIndex:(NSUInteger)index {
    return [self tagViewForIndex:index];
}


@end
