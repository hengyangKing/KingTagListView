//
//  TableViewManager.m
//  YQTTagsViewTest
//
//  Created by J on 2018/2/8.
//  Copyright © 2018年 J. All rights reserved.
//

#import "TableViewManager.h"
#import "NSString+GuardStr.h"
@interface TableViewManager()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, weak) id<YQTTagListCellDelegate> delegate;
@end

@implementation TableViewManager

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<YQTTagListCellDelegate>)delegate dataSource:(NSDictionary *)dataSource {
    self = [super init];
    if (self) {
        
        _tableView = tableView;
        _delegate = delegate;
        _dataSource = dataSource;
        [self setupTableView];
    }
    return self;
}
#pragma mark tableviewDatasource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YQTTagListBaseCell *cell;
    if (!indexPath.section) {
        cell =  [YQTTagListCell TagListCellWithTableView:tableView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cell selectTags];
        });
        
    }else if(indexPath.section == 1) {
        cell = [YQTTagRowCell TagListCellWithTableView:tableView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cell unSelectTags];
        });
        
        
    }else if(indexPath.section == 2){
        cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }else{
        cell = [YQTTagMultiLineRectangleCell TagListCellWithTableView:tableView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
    }
    !cell.tagListCellDataModel?:cell.tagListCellDataModel([self getCellModels:indexPath]);
    NSLog(@"%@",cell.currentSelectedTags);
    NSLog(@"------------------------------");

    [cell setDelegate:self.delegate];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YQTTagListCellDataModel *data = [self.dataSource objectForKey:[NSString stringWithFormat:@"%@",@(section)]];
    if (section && data.datas.count) {
        return [UIView new];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YQTTagListCellDataModel *data = [self.dataSource objectForKey:[NSString stringWithFormat:@"%@",@(section)]];

    if (section && data.datas.count) {
        return 32.f;
    }
    return 0.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}



#pragma mark - private methods
- (void)setupTableView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
}
- (void)reloadDataSource:(NSDictionary *)dataSource {
    self.dataSource = dataSource;
    [self changeBarState];
}
-(void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    [dataSource enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj_index, BOOL * _Nonnull stop) {
        if ([obj_index isKindOfClass:[NSArray class]]) {
            NSMutableArray *datas = [NSMutableArray array];
            
            [obj_index enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *str = (NSString *)[obj objectForKey:kTITLE];
                if (![str isEmpty]) {
                    YQTTagListCellModel *model = [[YQTTagListCellModel alloc]init];
                    model.title = str.guardStr;
                    model.selected = [[obj objectForKey:kSELECTED]boolValue];
                    [datas addObject:model];
                }
            }];
            YQTTagListCellDataModel *dataModel = [[YQTTagListCellDataModel alloc]init];
            dataModel.datas = datas;
            dataModel.appearModel.numberOfLines = 1;

            
            if (((NSString *)key).integerValue < 2) {
                dataModel.appearModel.numberOfLines = (((NSString *)key).integerValue+1);
            }
            if (((NSString *)key).integerValue == 1) {
                dataModel.appearModel.canDrawBack = NO;
            }
            if (((NSString *)key).integerValue == 0) {
                dataModel.appearModel.numberOfLines = 10;
            }
            [_dataSource setValue:dataModel forKey:key];
        }
    }];
    if (_dataSource) {
        [self.tableView reloadData];
    }

}
#pragma mark tableviewDatasource
-(YQTTagListCellDataModel *)getCellModels:(NSIndexPath *)indexpath {
    if (!self.dataSource.allKeys.count) {
        return nil;
    }
    YQTTagListCellDataModel *dataModel = [self.dataSource objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    if (indexpath.section == 3) {
        dataModel.appearModel.numberOfLines = 0;
        dataModel.appearModel.title = @"hahahahhahahahha";
    }
    return dataModel;
}
-(void)changeBarState {
//    BOOL state = YES;
//    if (!self.dataSource) {
//        state = NO;
//
//    }else{
//        ///不为空 且相等
//        if ((self.dataSource.deleteModel.words.count == self.dataSource.words.count) && self.dataSource.words.count) {
//            state = NO;
//        }
//        if ((self.dataSource.deleteModel.content_types.count == self.dataSource.content_types.count) &&self.dataSource.content_types.count){
//            state = NO;
//        }
//    }
//    !self.tagSelectedChangeBarState?:_tagSelectedChangeBarState(state);
}
@end
