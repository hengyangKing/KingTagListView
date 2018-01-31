//
//  YQTTagListBottomBar+CreateBar.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/30.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagListBottomBar.h"
@interface YQTTagListBottomBar (CreateBar)
///快速构建方法
+(instancetype)createTagListBottomBarWithSEL:(SEL)sel andTarget:(id)target;
@end
