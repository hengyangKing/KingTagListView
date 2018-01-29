//
//  YQTRectangleTagView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagBaseView.h"
#import "YQTRectangleTagConfig.h"
@interface YQTRectangleTagView : YQTTagBaseView
+(instancetype)YQTRectangleTagWithConfig:(void (^)(YQTRectangleTagConfig *config))config;

@end
