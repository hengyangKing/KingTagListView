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
#import "YQTAssignVocabularyOptionsModel.h"

#define kStatusBarHeight [[UIApplication sharedApplication]statusBarFrame].size.height

#define kNavBarHeight  self.navigationController.navigationBar.bounds.size.height

#define MAXNAVY (kStatusBarHeight + kNavBarHeight)//导航栏高

@interface TestViewController ()<YQTTagListCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;

@property(nonatomic,strong)YQTTagListBottomBar *bar;


@property(nonatomic,strong)YQTAssignVocabularyOptionsModel *dataSource;



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
    }
    return _tableview;
}
-(void)addDatas{
    self.dataSource = [[YQTAssignVocabularyOptionsModel alloc]init];
    NSArray *datas = @[@"[[NSAttributedString alloc]initWithString:[attr.string substringToIndex:1] attributes:[attr attributesAtIndex:1 effectiveRange:&range]]", @"assistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistantassistant", @"prophet", @"reetify", @"size", @"and", @"position",@"of", @"all", @"the", @"views", @"in", @"your", @"view", @"hierarchy", @"based",@"on", @"constraints", @"placed", @"on", @"those", @"views"];
    
    NSMutableArray *words = [NSMutableArray array];
    NSMutableArray *types = [NSMutableArray array];
    for (NSString *str in datas) {
        YQTAssignVocabularyOptionsContentType *content = [[YQTAssignVocabularyOptionsContentType alloc]init];
        content.name = str;
        [types addObject:content];
        
        YQTAssignVocabularyOptionsWord *word = [[YQTAssignVocabularyOptionsWord alloc]init];
        word.entext = str;
        
        [words addObject:word];
    }
    self.dataSource.words = [words copy];
    self.dataSource.content_types = [types copy];
    [self.bar show];
    [self.tableview reloadData];
}
#pragma mark tagListCellDelegate

///选中某tagview调用
- (void)tagListCell:(YQTTagListBaseCell *)cell didSelectTag:(UIView *)tagView atIndex:(NSUInteger)index {
    
    if ([cell isMemberOfClass:[YQTTagListCell class]]||[cell isMemberOfClass:[YQTTagRowCell class]]) {
        [self.dataSource selectWord:index];
    }else{
        [self.dataSource selectContent_type:index];
    }
}

///全部取消的回调
-(void)tagListCellUnselectAllTag:(YQTTagListBaseCell *)cell {
    [self.dataSource selectAllWords];
}

///全部选中的回调
-(void)tagListCellSelectAllTag:(YQTTagListBaseCell *)cell {
    [self.dataSource unSelectAllWords];
}
#pragma mark tableviewDatasource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    YQTTagListBaseCell *cell;
    if (!indexPath.section) {
        cell = [YQTTagListCell TagListCellWithTableView:tableView];
    }else {
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
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section ?[UIView new]:nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section?32.f:0;
}


-(NSArray <YQTTagCellModel *>*)getCellModels:(NSIndexPath *)indexpath {
    NSMutableArray *datas = [NSMutableArray array];
    
    if (!indexpath.row) {
        [self.dataSource.words enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsWord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
            model.title = obj.entext;
            model.selected = obj.selected;
            [datas addObject:model];
        }];
        return datas;
    }else{
        [self.dataSource.content_types enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsContentType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
            model.title = obj.name;
            model.selected = obj.selected;
            [datas addObject:model];
        }];
        return datas;
    }
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
