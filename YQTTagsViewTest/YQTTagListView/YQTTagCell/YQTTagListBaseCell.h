//
//  YQTTagListBaseCell.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/28.
//  Copyright © 2018年 J. All rights reserved.
//YQTTagListBaseCell 为YQTTagListView 调用的三种cell类型 的抽象基类
//直接调用子类使用

#import <UIKit/UIKit.h>
#import "YQTTagListCommon.h"
#import "YQTTagListBaseCellModel.h"
#import "YQTTagListCellDataModel.h"

@class YQTTagListBaseCell;
@class YQTTagBaseView;
@protocol YQTTagListCellDelegate <NSObject>

///选中某tagview调用
- (void)tagListCell:(YQTTagListBaseCell *)cell didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index;

///全部取消的回调
-(void)tagListCellUnselectAllTag:(YQTTagListBaseCell *)cell;

///全部选中的回调
-(void)tagListCellSelectAllTag:(YQTTagListBaseCell *)cell;

@optional
///将要选中某tagview调用
- (BOOL)tagListCell:(YQTTagListBaseCell *)cell shouldSelectTag:(UIView *)tagView atIndex:(NSUInteger)index;

@end
@interface YQTTagListBaseCell : UITableViewCell

///id
+(NSString *)YQTTagViewCellID ;

///数据源
@property(nonatomic,strong,readonly)YQTTagListCellDataModel *dataModel;

@property(nonatomic,copy,readonly)void (^tagListCellDataModel)(YQTTagListCellDataModel *dataModel);

///代理 父类声明 子类调用
@property(nonatomic,weak)id<YQTTagListCellDelegate> delegate;

///父类子类通信

///点击tag 子类需要通知父类 修改header状态
@property(nonatomic,copy,readonly)void (^selectTag)(UIView *);


///子类通知父类需要刷新UI 调用 子类展示的tags
@property(nonatomic,copy,readonly)void (^layoutSubview)(YQTTagListBaseCellModel *model);

#pragma mark add newfuncs

/**
 当前cell 被选中的 items
 dic is {
            @"index":index,
            @"tag":tagview,
        }
 */
@property(nonatomic,copy,readonly)NSArray <NSDictionary *>*currentSelectedTags;

/**
 将当前cell 内 所有tag 全部取消选中
 */
-(void)unSelectTags;

/**
 将当前cell 内 所有tag 全部选中
 */
-(void)selectTags;

@end
