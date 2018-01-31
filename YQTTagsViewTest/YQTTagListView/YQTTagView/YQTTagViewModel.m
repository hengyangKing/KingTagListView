//
//  YQTTagViewModel.m
//  YQTTagsViewTest
//
//  Created by J on 2018/1/31.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagViewModel.h"

@implementation YQTTagViewModel

-(void)setTitle:(NSString *)title
{
    _title = title;
    
}
-(void)setAttrTitle:(NSAttributedString *)attrTitle
{
    _attrTitle = attrTitle;
}

-(void)setSelectedTitle:(NSAttributedString *)selectedTitle
{
    _selectedTitle = selectedTitle;
}

@end
