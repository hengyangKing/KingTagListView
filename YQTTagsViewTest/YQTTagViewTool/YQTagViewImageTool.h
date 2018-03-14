//
//  YQTagViewImageTool.h
//  YQTTagsViewTest
//
//  Created by J on 2018/2/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQTTagsViewConfig.h"
#define kBGCOLOR @"color"
#define kBORDERCOLOR @"borderColor"
#define kBORDERWIDTH @"borderWidth"
#define kCORNERRADIUS @"cornerRadius"

@interface YQTagViewImageTool : NSObject
@property(nonatomic,strong,readonly)UIImage *image;
@property(nonatomic,copy,readonly)void (^AppearanceConfig)(NSDictionary *config);
@property(nonatomic,strong,readonly)UIImage *stretchableImage;

@end
