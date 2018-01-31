//
//  YQTTagViewModel.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/31.
//  Copyright © 2018年 J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQTTagViewModel : NSObject






@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign,getter=isSelected)BOOL selected;





@property(nonatomic,copy,readonly)NSAttributedString *attrTitle;
@property(nonatomic,copy,readonly)NSAttributedString *selectedTitle;




@end
