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

@property(nonatomic,strong)YQTTagListBottomBar *bar;


///key == indexpath value == 可变数组数据源
@property(nonatomic,strong)NSMutableDictionary *datas;

///key == indexpath value == 删除的可变数组
@property(nonatomic,strong)NSMutableDictionary *delectDatas;


@end

@implementation TestViewController
-(YQTTagListBottomBar *)bar {
    if (!_bar) {
        _bar = [YQTTagListBottomBar createTagListBottomBarWithSEL:@selector(foo) andTarget:self];
    }
    return _bar;
}
-(NSMutableDictionary *)datas {
    if (!_datas) {
        _datas = [NSMutableDictionary dictionary];
    }
    return _datas;
}
-(NSMutableDictionary *)delectDatas {
    if (!_delectDatas) {
        _delectDatas = [NSMutableDictionary dictionary];
    }
    return _delectDatas;
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
    }
    return _tableview;
}
-(void)addDatas{
    NSArray *datas = @[@"[[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]]", @"assistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistant", @"prophet", @"reetify", @"size", @"and", @"position",@"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",@"on", @"constraints", @"placed", @"on", @"those", @"views"];
    for (NSInteger i = 0; i<3; i++) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *str in datas) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:str forKey:@"title"];
            [dic setObject:[NSNumber numberWithInt:rand()%2] forKey:@"selected"];
            [array addObject:dic];
        }
        [self.datas setValue:array forKey:[NSString stringWithFormat:@"%@",@(i)]];
    }
    
    [self.bar show];
    [self.tableview reloadData];
}
#pragma mark tagListCellDelegate

///选中某tagview调用
- (void)tagListCell:(YQTTagListBaseCell *)cell didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if (!self.datas.allValues.count) {
        return;
    }
    
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    if (indexpath.section>(self.datas.allValues.count-1)) {
        return;
    }
    NSArray *array = [self.datas objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    if (index>array.count-1) {
        return;
    }
    NSDictionary *obj = [array objectAtIndex:index];
    
    NSMutableArray *delectArr = [NSMutableArray arrayWithArray:[self.delectDatas objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]]];
    
    //词汇或句子
    BOOL select = obj[@"selected"];
    [obj setValue:@(!select) forKey:@"selected"];
    
    if ([delectArr containsObject:obj]) {
        //包含
        [delectArr removeObject:obj];
    }else{
        //不包含
        [delectArr addObject:obj];
    }
    [self.delectDatas setValue:delectArr forKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];

}

///全部取消的回调
-(void)tagListCellUnselectAllTag:(YQTTagListBaseCell *)cell {
    
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    [self.delectDatas setValue:@{} forKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    
}

///全部选中的回调
-(void)tagListCellSelectAllTag:(YQTTagListBaseCell *)cell {
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];

    NSArray *array = [self.datas objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    
    [self.delectDatas setValue:array forKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
}



#pragma mark tableviewDatasource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    YQTTagListBaseCell *cell;
    if (!indexPath.section) {
        cell = [YQTTagListCell TagListCellWithTableView:tableView];
    }else if(indexPath.section == 1){
        cell = [YQTTagRowCell TagListCellWithTableView:tableView];
    }else{
        cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
    }
    !cell.datas?:cell.datas([self getCellModels:indexPath]);
    [cell setDelegate:self];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.allValues.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section ?[UIView new]:nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section?32.f:0;
}


-(NSArray <YQTTagCellModel *>*)getCellModels:(NSIndexPath *)indexpath {
    
    NSMutableArray *datas = [NSMutableArray array];
    if (!self.datas.allValues.count) {
        return datas;
    }
    NSArray *data = [self.datas objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    [data enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
        model.title = obj[@"title"];
        model.selected = obj[@"selected"];
        [datas addObject:model];
    }];
    return datas;
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
