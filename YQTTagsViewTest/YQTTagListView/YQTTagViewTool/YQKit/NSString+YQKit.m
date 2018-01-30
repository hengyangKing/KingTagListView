//
//  NSString+YQKit.m
//  YIQIStudent
//
//  Created by jiangkun.yang on 15/12/4.
//  Copyright © 2015年 yangkun. All rights reserved.
//

#import "NSString+YQKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YQKit)



//添加key和value
-(NSString*)addUrlKeyAndValue:(NSString*)strKey Value:(NSString*)strValue
{
    
    return  [NSString stringWithFormat:@"%@&%@=%@",self,strKey,strValue];
    
    
}

-(NSString*)urltojsonstring
{
    if([NSString isLegalString:self])
    {
        //去掉特殊字符
        NSString *strUrl = self;
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\b" withString:@"\\b"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\v" withString:@"\\v"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\uFEFF" withString:@"\\uFEFF"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\u00A0" withString:@"\\u00A0"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\u200D" withString:@"\\u200D"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\u200F" withString:@"\\u200F"];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\u200E" withString:@"\\u200E"];
        
        return strUrl;
    }
    return self;
}
+(BOOL)isLegalString:(NSString*)desString
{
    if(desString != nil && ![desString isEqualToString:@""] && ![desString isEqualToString:@"(null)"]  && ![desString isEqualToString:@"<null>"]&& desString != (NSString*)[NSNull null])
        return YES;
    return NO;
}

#pragma mark - 通用方法
+(NSString *)getLastName:(NSString *)url
{
    NSString * serverUrlPathExtension = [[url lastPathComponent] stringByDeletingPathExtension];
    return serverUrlPathExtension;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                              (CFStringRef)self,
                                                                              CFSTR(""),
                                                                              kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    return encodedString;
}


- (NSString * _Nullable)MD5 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString * _Nullable)SHA1 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i=0;i<CC_SHA1_DIGEST_LENGTH;i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString * _Nullable)SHA256 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i=0;i<CC_SHA256_DIGEST_LENGTH;i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString * _Nullable)SHA512 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i=0;i<CC_SHA512_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}


- (BOOL)isEmail {
    return [NSString isEmail:self];
}

+ (BOOL)isEmail:(NSString * _Nonnull)email {
    NSString *emailRegEx = @"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

+ (NSString * _Nonnull)encodeToBase64:(NSString * _Nonnull)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString * _Nonnull)encodeToBase64 {
    return [NSString encodeToBase64:self];
}

+ (NSString * _Nonnull)decodeBase64:(NSString * _Nonnull)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString * _Nonnull)decodeBase64 {
    return [NSString decodeBase64:self];
}

- (NSString * _Nonnull)sentenceCapitalizedString {
    if (![self length]) {
        return @"";
    }
    NSString *uppercase = [[self substringToIndex:1] uppercaseString];
    NSString *lowercase = [[self substringFromIndex:1] lowercaseString];
    
    return [uppercase stringByAppendingString:lowercase];
}

- (NSString * _Nonnull)dateFromTimestamp {
    NSString *year = [self substringToIndex:4];
    NSString *month = [[self substringFromIndex:5] substringToIndex:2];
    NSString *day = [[self substringFromIndex:8] substringToIndex:2];
    NSString *hours = [[self substringFromIndex:11] substringToIndex:2];
    NSString *minutes = [[self substringFromIndex:14] substringToIndex:2];
    
    return [NSString stringWithFormat:@"%@/%@/%@ %@:%@", day, month, year, hours, minutes];
}

- (NSString * _Nonnull)urlEncode {
    return [self URLEncode];
}

- (NSString * _Nonnull)URLEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString * _Nonnull)urlEncodeWithAllowedCharacters {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString * _Nonnull)removeExtraSpaces {
    NSString *squashed = [self stringByReplacingOccurrencesOfString:@"[ ]+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    return [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString * _Nonnull)stringByReplacingWithRegex:(NSString * _Nonnull)regexString withString:(NSString * _Nonnull)replacement {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
}

- (NSString * _Nonnull)HEXToString {
    NSMutableString *newString = [NSMutableString string];
    NSArray *components = [self componentsSeparatedByString:@" "];
    for (NSString * component in components) {
        int value = 0;
        sscanf([component cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
    }
    return newString;
}

- (NSString * _Nonnull)stringToHEX {
    NSUInteger len = [self length];
    unichar *chars = malloc(len * sizeof(unichar));
    [self getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0; i < len; i++ ) {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    free(chars);
    
    return hexString;
}

+ (NSString * _Nonnull)generateUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}


- (CGSize)zySizeWithFont:(UIFont *)strFont constrainedToSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize size = CGSizeMake(0.0, 0.0);
    if (!self) {
        return size;
    }
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 1.0;
    size = [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{ NSFontAttributeName : strFont }
                              context:context].size;
    return size;
}
-(BOOL)isChinese
{
//    NSString * regex = @"^[\u4E00-\u9FA5]*$";
    NSString * regex = @"^[\u4D00-\u9FBF]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isUrl
{
    NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isIPAddress
{
    NSArray *			components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}

- (BOOL)isValidateMobile
{
    NSString * MOBILE = @"^[1-9]\\d{10}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:self];
}


- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(NSString*)urlJsonStr
{
    return [self urltojsonstring];
}
-(BOOL)isIncludeString:(NSString*)strSubString
{
    if(strSubString==nil || [strSubString isEqualToString:@""]|| strSubString == (NSString*)[NSNull null])
        return NO;
    //判断字符串是否包含
    NSRange range = [self rangeOfString:strSubString];
    //if (range.location ==NSNotFound)//不包含
    if (range.length >0)//包含
        return YES;
    return NO;
}

- (BOOL)match:(NSString *)expression
{
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    if ( nil == regex )
        return NO;
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, self.length)];
    if ( 0 == numberOfMatches )
        return NO;
    
    return YES;
}

- (BOOL)matchAnyOf:(NSArray *)array
{
    for ( NSString * str in array )
    {
        if ( NSOrderedSame == [self compare:str options:NSCaseInsensitiveSearch] )
        {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

+(NSMutableAttributedString *)setLabelText:(NSString *)text withAttribute:(NSArray *)attributeArr
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    
    for (NSDictionary * attDic in attributeArr)
    {
        NSRange range = [[attDic valueForKey:@"range"] rangeValue];
        UIColor * color = [attDic valueForKey:@"color"];
        UIFont * fond = [attDic valueForKey:@"font"];
        
        [str addAttribute:NSFontAttributeName value:fond range:range];
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return str;
}

- (NSString *)switchToPinYin {
    if (self == nil) {
        return nil;
    }
    CFStringRef cfStr = (__bridge CFStringRef)(self);
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, cfStr);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    return [(__bridge NSString *)(string) lowercaseString];
}

- (BOOL) isEmpty {
    
    if (!self) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
@end
