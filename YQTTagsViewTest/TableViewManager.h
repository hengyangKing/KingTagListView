//
//  TableViewManager.h
//  YQTTagsViewTest
//
//  Created by J on 2018/2/8.
//  Copyright © 2018年 J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YQTTagListCell.h"
#import "YQTTagRowCell.h"
#import "YQTTagRectangleCell.h"
#import "YQTTagMultiLineRectangleCell.h"


#define kTITLE @"title"
#define kSELECTED @"selected"

@interface TableViewManager<AnyObject> : NSObject<UITableViewDelegate, UITableViewDataSource>

/**
 对象方法创建tableView
 
 @param tableView tableView
 @return          创建的对象
 */

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<YQTTagListCellDelegate>)delegate dataSource:(NSDictionary *)dataSource;

- (void)reloadDataSource:(NSDictionary *)dataSource;

@property(nonatomic,copy)void (^tagSelectedChangeBarState)(BOOL state);

@end
