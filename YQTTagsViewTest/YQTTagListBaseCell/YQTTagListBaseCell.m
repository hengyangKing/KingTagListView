//
//  YQTTagListBaseCell.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBaseCell.h"
#import "YQTTagListHeaderView.h"
#import "Masonry.h"

@interface YQTTagListBaseCell()
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
    [self.contentView addSubview:self.header];
    __weak typeof(self) weakself = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.contentView);
        make.leading.mas_equalTo(weakself.contentView).mas_offset(ListTagPadding);
        make.trailing.mas_equalTo(weakself.contentView).mas_offset(-ListTagPadding);
        make.height.mas_equalTo(TagListHeaderH);
    }];
    [self.contentView addSubview:self.taglistView];
    [self.taglistView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakself.header.mas_leading);
        make.trailing.mas_equalTo(weakself.header.mas_trailing);
        make.top.mas_equalTo(weakself.header.mas_bottom).mas_offset(15.f);
        make.bottom.mas_equalTo(weakself.contentView.mas_bottom);
    }];
}

#pragma mark lazy
-(TTGTagCollectionView *)taglistView {
    if (!_taglistView) {
        _taglistView = [[TTGTagCollectionView alloc]initWithFrame:CGRectZero];
        _taglistView.verticalSpacing = 4.f;
        _taglistView.horizontalSpacing = 2.f;
    }
    return _taglistView;
}
-(YQTTagListHeaderView *)header {
    if (!_header) {
        __weak typeof(self) weakself = self;
        _header = [YQTTagListHeaderView TagListHeaderViewWith:^(YQTTagListHeaderConfig *config) {
            config.needHiddenButton(NO);
            config.radius(TagListHeaderH/2.0f);
            
        } andButtonClick:^(TagListHeaderButtonState state) {
            !weakself.headerViewClick?:weakself.headerViewClick(state);
            [self.deleteTags removeAllObjects];
            if (state == ButtonStateIsSelectAll) {
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
-(void (^)(YQTTagListBaseCell *))setTagsViewDelegate {
    
    return ^(YQTTagListBaseCell *cell){
        self.taglistView.delegate = cell;
        self.taglistView.dataSource = cell;
    };
}
-(void (^)(UIView *))selectTag {
    return ^(UIView *view){
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
    };
}
-(void (^)(NSString *, NSArray<UIView *> *))layoutSubview {
    return ^(NSString *title, NSArray<UIView *> *tags){
        self.header.headerTitle(title);
        [self.tags removeAllObjects];
        [self.tags addObjectsFromArray:tags];
        [self.taglistView reload];
    };
}



@end
