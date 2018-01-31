//
//  ViewController.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
//

#import "ViewController.h"
#import "YQTTagListCell.h"
#import "YQTTagRowCell.h"
#import "YQTTagRectangleCell.h"
#import "TestViewController.h"
@interface ViewController ()<YQTTagListCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *datas;
///存放需要被删除的tag
@property(nonatomic,strong)NSMutableArray *deleteTags;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    return;
    [self.view addSubview:self.tableview];
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 15;
    [self performSelector:@selector(addDatas) withObject:self afterDelay:3.0];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *test = [[TestViewController alloc]init];
    test.title = @"词汇基础练习";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:nil];
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        CGFloat color = 245.0/255.0;
        [_tableview setBackgroundColor:[UIColor colorWithRed:color green:color blue:color alpha:1.0f]];
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
    [self.datas addObjectsFromArray:@[@"[[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]]", @"assistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistant", @"prophet", @"reetify", @"size", @"and", @"position",@"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",@"on", @"constraints", @"placed", @"on", @"those", @"views"]];
    
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
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
