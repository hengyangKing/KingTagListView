//
//  NSString+GuardStr.m
//  YQTTagsViewTest
//
//  Created by J on 2018/3/2.
//  Copyright © 2018年 J. All rights reserved.
//

#import "NSString+GuardStr.h"

@implementation NSString (GuardStr)
-(NSString *)guardStr {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(BOOL)isEmpty {
    // 想要过滤的字符串
    NSString * originalString = self.guardStr;
    NSArray *rules = @[@"\r",@"\n",@"\t"];
    for (NSString *rule in rules) {
        originalString = [originalString stringByReplacingOccurrencesOfString:rule withString:@""];
    }
    return !originalString.length;
}
@end
