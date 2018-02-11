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
#import "TableViewManager.h"


#define kStatusBarHeight [[UIApplication sharedApplication]statusBarFrame].size.height

#define kNavBarHeight  self.navigationController.navigationBar.bounds.size.height

#define MAXNAVY (kStatusBarHeight + kNavBarHeight)//导航栏高



@interface TestViewController ()<YQTTagListCellDelegate>

@property(strong,nonatomic)UITableView *tableview;

@property(nonatomic,strong)YQTTagListBottomBar *bar;


///key == indexpath value == 可变数组数据源
@property(nonatomic,strong)NSMutableDictionary *datas;

///key == indexpath value == 删除的可变数组
@property(nonatomic,strong)NSMutableDictionary *delectDatas;

@property(nonatomic,strong)TableViewManager *manager;

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
        _manager = [[TableViewManager alloc]initWithTableView:_tableview delegate:self dataSource:self.datas];
        _tableview.contentInset = UIEdgeInsetsMake(MAXNAVY, 0, self.bar.barH, 0);
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.rowHeight = UITableViewAutomaticDimension;
        _tableview.estimatedRowHeight = 44;
    }
    
    return _tableview;
}
-(void)addDatas{
//    NSArray *datas = @[@"[[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]]", @"assistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistant", @"prophet", @"reetify", @"size", @"and", @"position",@"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",@"on", @"constraints", @"placed", @"on", @"those", @"views"];
    NSArray *datas = @[@"[[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]]",@"1",@"2",@"3",@"4",@"5"];
    for (NSInteger i = 0; i<3; i++) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *str in datas) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:str forKey:kTITLE];
            [dic setObject:[NSNumber numberWithBool:rand()%2] forKey:kSELECTED];
            [array addObject:dic];
        }
        [self.datas setValue:array forKey:[NSString stringWithFormat:@"%@",@(i)]];
    }
    
    [self.bar show];
    [self.manager reloadDataSource:self.datas];
}
#pragma mark tagListCellDelegate

///选中某tagview调用
- (void)tagListCell:(YQTTagListBaseCell *)cell didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    if (!self.datas.allKeys.count) {
        return;
    }
    
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    if (indexpath.section>(self.datas.allKeys.count-1)) {
        return;
    }
    NSArray *array = [self.datas objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    if (index>array.count-1) {
        return;
    }
    NSDictionary *obj = [array objectAtIndex:index];
    
    NSMutableArray *delectArr = [NSMutableArray arrayWithArray:[self.delectDatas objectForKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]]];
    
    //词汇或句子
    BOOL select = [obj objectForKey:kSELECTED];
    [obj setValue:@(!select) forKey:kSELECTED];
    
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
    [self.delectDatas setValue:@[] forKey:[NSString stringWithFormat:@"%@",@(indexpath.section)]];
    
}
///全部选中的回调
-(void)tagListCellSelectAllTag:(YQTTagListBaseCell *)cell {
	    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
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
-(void)foo
{
    NSLog(@"%s",__func__);
}


@end
