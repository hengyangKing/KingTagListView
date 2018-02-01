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
        _tableview.estimatedRowHeight = 0.1f;
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
//    self.dataSource.content_types = [types copy];
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
    if (!indexPath.row) {
        NSMutableArray *datas = [NSMutableArray array];
        [self.dataSource.words enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsWord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
            model.title = obj.entext;
            model.selected = obj.selected;
            [datas addObject:model];
        }];
        cell = [YQTTagListCell TagListCellWithTableView:tableView];
        cell.datas(datas);
        [cell setDelegate:self];
        
    }else{
        NSMutableArray *datas = [NSMutableArray array];
        [self.dataSource.content_types enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsContentType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
            model.title = obj.name;
            model.selected = obj.selected;
            [datas addObject:model];
        }];
        cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
        cell.datas(datas);
        [cell setDelegate:self];
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self cellCount];
}
-(NSUInteger)cellCount {
    NSInteger count = 0;
    if (self.dataSource.words.count) {
        count = count+1;
    }
    if (self.dataSource.content_types.count) {
        count = count+1;
    }
    return count;
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


-(void)fooooo{
    /*
     YQTTagListBaseCell *cell ;
     NSMutableArray *datas = [NSMutableArray array];
     
     if (self.dataSource.words.count && self.dataSource.content_types.count) {
     if (!indexPath.row) {
     cell = [YQTTagListCell TagListCellWithTableView:tableView];
     [self.dataSource.words enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsWord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.entext;
     model.selected = obj.selected;
     [datas addObject:model];
     }];
     }else{
     cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
     [self.dataSource.content_types enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsContentType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.name;
     model.selected = obj.selected;
     [datas addObject:model];
     }];
     }
     }else if (self.dataSource.words.count&&(!self.dataSource.content_types.count)) {
     cell = [YQTTagListCell TagListCellWithTableView:tableView];
     
     [self.dataSource.words enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsWord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.entext;
     model.selected = obj.selected;
     [datas addObject:model];
     }];
     }else if ((!self.dataSource.words.count)&&self.dataSource.content_types.count) {
     cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
     
     [self.dataSource.content_types enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsContentType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.name;
     model.selected = obj.selected;
     [datas addObject:model];
     }];
     }
     cell.datas(datas);
     [cell setDelegate:self];
     return cell;
     
     
     
     
     if (self.dataSource.words.count && self.dataSource.content_types.count) {
     ///正常情况
     if (!indexPath.row) {
     YQTTagListCell *cell = [YQTTagListCell TagListCellWithTableView:tableView];
     NSMutableArray *words = [NSMutableArray array];
     [self.dataSource.words enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsWord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.entext;
     model.selected = obj.selected;
     [words addObject:model];
     }];
     cell.datas([words copy]);
     [cell setDelegate:self];
     
     return cell;
     }else{
     YQTTagRectangleCell *cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
     
     NSMutableArray *content_types = [NSMutableArray array];
     [self.dataSource.content_types enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsContentType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.name;
     model.selected = obj.selected;
     [content_types addObject:model];
     }];
     cell.datas([content_types copy]);
     [cell setDelegate:self];
     
     return cell;
     }
     }else if(self.dataSource.words.count&&(!self.dataSource.content_types.count)) {
     //只有tag
     YQTTagListCell *cell = [YQTTagListCell TagListCellWithTableView:tableView];
     
     NSMutableArray *words = [NSMutableArray array];
     [self.dataSource.words enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsWord * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.entext;
     model.selected = obj.selected;
     [words addObject:model];
     }];
     cell.datas([words copy]);
     [cell setDelegate:self];
     return cell;
     }else if((!self.dataSource.words.count)&&self.dataSource.content_types.count) {
     //只有content_type
     YQTTagRectangleCell *cell = [YQTTagRectangleCell TagListCellWithTableView:tableView];
     
     NSMutableArray *content_types = [NSMutableArray array];
     [self.dataSource.content_types enumerateObjectsUsingBlock:^(YQTAssignVocabularyOptionsContentType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     YQTTagCellModel *model = [[YQTTagCellModel alloc]init];
     model.title = obj.name;
     model.selected = obj.selected;
     [content_types addObject:model];
     }];
     cell.datas([content_types copy]);
     [cell setDelegate:self];
     return cell;
     }else{
     return nil;
     }
     */
    
}

@end
