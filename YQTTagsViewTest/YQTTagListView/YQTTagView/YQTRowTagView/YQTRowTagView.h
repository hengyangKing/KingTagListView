//
//  YQTRowTagView.h
//  YQTTagsViewTest
//
//  Created by J on 2018/1/29.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTTagBaseView.h"
@interface YQTRowTagView : YQTTagBaseView

+(instancetype)YQTRowTagWithConfig:(void (^)(YQTTagsViewConfig *config))config;

@end
