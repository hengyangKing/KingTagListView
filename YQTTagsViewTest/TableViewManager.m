//
//  TableViewManager.m
//  YQTTagsViewTest
//
//  Created by J on 2018/2/8.
//  Copyright © 2018年 J. All rights reserved.
//

#import "TableViewManager.h"
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
        cell =  [YQTTagRowCell TagListCellWithTableView:tableView];
    }else if(indexPath.section == 1) {
        cell = [YQTTagListCell TagListCellWithTableView:tableView];
    }else{
        cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
    }
    !cell.datas?:cell.datas([self getCellModels:indexPath]);
    [cell setDelegate:self.delegate];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.allKeys.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *data = [self.dataSource objectForKey:[NSString stringWithFormat:@"%@",@(section)]];
    if (section && data.count) {
        return [UIView new];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *data = [self.dataSource objectForKey:[NSString stringWithFormat:@"%@",@(section)]];

    if (section && data.count) {
        return 32.f;
    }
    return 0.f;
}
#pragma mark - private methods
- (void)setupTableView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
}
- (void)reloadDataSource:(NSDictionary *)dataSource {
    self.dataSource = dataSource;
    [self changeBarState];
}
-(void)setDataSource:(NSDictionary *)dataSource {
    _dataSource = dataSource;
    if (_dataSource) {
        [self.tableView reloadData];
    }
}
#pragma mark tableviewDatasource
-(NSArray <YQTTagListCellModel *>*)getCellModels:(NSIndexPath *)indexpath {
    
    NSMutableArray *datas = [NSMutableArray array];
    if (!self.dataSource.allKeys.count) {
        return datas;
    }
    NSArray *data = [self.dataSource objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YQTTagListCellModel *model = [[YQTTagListCellModel alloc]init];
        model.title = [obj objectForKey:kTITLE];
        model.selected = [[obj objectForKey:kSELECTED]boolValue];
        [datas addObject:model];
    }];
    return datas;
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
