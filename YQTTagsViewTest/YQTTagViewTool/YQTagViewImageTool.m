//
//  YQTagViewImageTool.m
//  YQTTagsViewTest
//
//  Created by J on 2018/2/28.
//  Copyright © 2018年 J. All rights reserved.
//

#import "YQTagViewImageTool.h"
#import "UIColor+YQKit.h"
#import "HYBImageCliped.h"
#define COLORSTR(color) [UIColor hexFromUIColor:color]

@interface YQTagViewImageTool()

@property(nonatomic,strong)NSDictionary *config;
@end
@implementation YQTagViewImageTool
-(void (^)(NSDictionary *))AppearanceConfig {
    return ^(NSDictionary *config){
        if (![self isEqualAppearanceConfig:config]) {
            [self setConfig:config];
        }
    };
}

-(void)setConfig:(NSDictionary *)config {
    _config = config;
    CGSize size = CGSizeMake(1, 1);
    CGFloat f = ((NSNumber *)[_config valueForKey:kCORNERRADIUS]).floatValue;
    if (!f) {
        size = CGSizeMake(f*2, f*2);
    }
    
    _image = [UIImage hyb_imageWithColor:[_config valueForKey:kBGCOLOR] toSize:size cornerRadius:f backgroundColor:[_config valueForKey:kBGCOLOR] borderColor:[_config valueForKey:kBORDERCOLOR] borderWidth:((NSNumber *)[_config valueForKey:kBORDERWIDTH]).floatValue];
}
-(NSString *)getColorStrWithColor:(UIColor *)color {
    if (color) {
        NSString *colorStr =COLORSTR(color);
        return colorStr.length?colorStr:@"";
    }
    return @"";
}
-(BOOL)isEqualAppearanceConfig:(NSDictionary *)config {
    BOOL isEqual = YES;
    
    if (![[self getColorStrWithColor:[config valueForKey:kBGCOLOR]] isEqualToString:[self getColorStrWithColor:[self.config valueForKey:kBGCOLOR]]] ) {
        isEqual = NO;
    }
    if (![[self getColorStrWithColor:[config valueForKey:kBORDERCOLOR]] isEqualToString:[self getColorStrWithColor:[self.config valueForKey:kBORDERCOLOR]]]) {
        isEqual = NO;
    }
    if (((NSNumber *)[config valueForKey:kBORDERWIDTH]).floatValue != ((NSNumber *)[self.config valueForKey:kBORDERWIDTH]).floatValue) {
        isEqual = NO;
    }
    if (((NSNumber *)[config valueForKey:kCORNERRADIUS]).floatValue != ((NSNumber *)[self.config valueForKey:kCORNERRADIUS]).floatValue) {
        isEqual = NO;
    }
    return isEqual;
}

@end
