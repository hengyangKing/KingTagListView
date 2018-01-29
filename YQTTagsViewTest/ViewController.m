//
//  ViewController.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
//

#import "ViewController.h"
#import "YQTTagListCell.h"



@interface ViewController ()<YQTTagListCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *datas;
///存放需要被删除的tag
@property(nonatomic,strong)NSMutableArray *deleteTags;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 15;
    [self performSelector:@selector(addDatas) withObject:self afterDelay:3.0];
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
-(NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)deleteTags {
    if (!_deleteTags) {
        _deleteTags = [NSMutableArray array];
    }
    return _deleteTags;
}

-(void)addDatas{
    [self.datas addObjectsFromArray:@[@"photo photo photo photo photo photo photo photo photo photo photo photo photo photo photo photo", @"assistant", @"prophet", @"reetify", @"size", @"and", @"position",@"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",@"on", @"constraints", @"placed", @"on", @"those", @"views"]];
    
    [self.tableview reloadData];
}
#pragma mark tagListCellDelegate

- (void)tagListCell:(YQTTagListCell *)cell didSelectTag:(YQTTagView *)tagView atIndex:(NSUInteger)index {
    id data = self.datas[index];
    if ([self.deleteTags containsObject:data]) {
        //包含
        [self.deleteTags removeObject:data];
    }else{
        //不包含
        [self.deleteTags addObject:data];
    }
}

- (void)tagListCellSelectAllTag:(YQTTagListCell *)cell {
    
}

- (void)tagListCellUnselectAllTag:(YQTTagListCell *)cell {
    
}

#pragma mark tableviewDatasource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (!indexPath.section) {
        YQTTagListCell *cell = [YQTTagListCell TagListCellWithTableView:tableView];
        cell.datas(self.datas);
        [cell setDelegate:self];
        return cell;
    }
    return nil;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
