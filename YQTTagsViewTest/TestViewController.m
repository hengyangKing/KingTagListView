//
//  TestViewController.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/27.
//  Copyright © 2018年 J. All rights reserved.
//

#import "TestViewController.h"
///快速构造方法调用
#import "YQTTagListBottomBar+CreateBar.h"

#import "YQTTagListCell.h"
#import "YQTTagRowCell.h"
#import "YQTTagRectangleCell.h"


#define kStatusBarHeight [[UIApplication sharedApplication]statusBarFrame].size.height

#define kNavBarHeight  self.navigationController.navigationBar.bounds.size.height

#define MAXNAVY (kStatusBarHeight + kNavBarHeight)//导航栏高

@interface TestViewController ()<YQTTagListCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *datas;
///存放需要被删除的tag
@property(nonatomic,strong)NSMutableArray *deleteTags;
@property(nonatomic,strong)YQTTagListBottomBar *bar;
@end

@implementation TestViewController
-(YQTTagListBottomBar *)bar {
    if (!_bar) {
        _bar = [YQTTagListBottomBar createTagListBottomBarWithSEL:@selector(foo) andTarget:self];
    }
    return _bar;
}
-(UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        CGFloat color = 245.0/255.0;
        [_tableview setBackgroundColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.contentInset = UIEdgeInsetsMake(MAXNAVY, 0, self.bar.barH, 0);
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.rowHeight = UITableViewAutomaticDimension;
        _tableview.estimatedRowHeight = 15;
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
    [self.datas addObjectsFromArray:@[@"[[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]]", @"assistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistant", @"prophet", @"reetify", @"size", @"and", @"position",@"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",@"on", @"constraints", @"placed", @"on", @"those", @"views"]];
    [self.bar show];
    [self.tableview reloadData];
}
#pragma mark tagListCellDelegate

- (void)tagListCell:(YQTTagListCell *)cell didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
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
    [self.deleteTags removeAllObjects];
    [self.deleteTags addObjectsFromArray:[self.datas copy]];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    NSLog(@"%@",indexPath);
    
    
}

- (void)tagListCellUnselectAllTag:(YQTTagListCell *)cell {
    [self.deleteTags removeAllObjects];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    NSLog(@"%@",indexPath);
}

#pragma mark tableviewDatasource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YQTTagListBaseCell *cell;
    if (!indexPath.row) {
        cell = [YQTTagListCell TagListCellWithTableView:tableView];
    }else{
        cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
    }
    cell.datas(self.datas);
    [cell setDelegate:self];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(void)foo
{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.view .backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.bar];
    [self performSelector:@selector(addDatas) withObject:self afterDelay:3.0];
}

@end
