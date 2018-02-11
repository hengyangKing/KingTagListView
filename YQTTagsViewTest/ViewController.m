//
//  ViewController.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/25.
//  Copyright © 2018年 J. All rights reserved.
//

#import "ViewController.h"

#import "TestViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(touchesBegan:withEvent:) withObject:self afterDelay:.5f];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController *test = [[TestViewController alloc]init];
    test.title = @"词汇基础练习";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:nil];
}




@end
