//
//  NSString+YQKit.h
//  YIQIStudent
//
//  Created by jiangkun.yang on 15/12/4.
//  Copyright © 2015年 yangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YQKit)

- (NSString*_Nonnull)URLDecodedString;
- (NSString *_Nonnull)URLEncodedString;
-(NSString*_Nonnull)addUrlKeyAndValue:(NSString*_Nonnull)strKey Value:(NSString*_Nonnull)strValue;

//计算文字的宽高
- (CGSize)zySizeWithFont:(UIFont * _Nonnull)strFont constrainedToSize:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (BOOL)isChinese; // 是否为中文字符
- (BOOL)isUrl;
- (BOOL)isValidateMobile;
- (BOOL)isIPAddress;
- (BOOL)isPureInt; // 是否为整形数字
- (NSString * _Nonnull)urlJsonStr; // 转义 “ ‘ / 等
- (BOOL) isIncludeString:(NSString * _Nonnull)strSubString; //字符串是否包含
- (BOOL)match:(NSString *_Nonnull)expression;
- (BOOL)matchAnyOf:(NSArray *_Nonnull)array;
- (NSString *_Nonnull)stringByTrim;
- (NSString*_Nonnull)urltojsonstring;
+(BOOL)isLegalString:(NSString*_Nonnull)desString;
#pragma mark - 通用方法
+(NSString *_Nonnull)getLastName:(NSString *_Nonnull)url;
- (BOOL) isEmpty;
/**
 *  转换为拼音，不带声调
 *
 *  @return 拼音
 */
- (NSString * _Nullable)switchToPinYin;
/**
 *  Create a MD5 string from self
 *
 *  @return Returns the MD5 NSString from self
 */
- (NSString * _Nullable)MD5;

/**
 *  Create a SHA1 string from self
 *
 *  @return Returns the SHA1 NSString from self
 */
- (NSString * _Nullable)SHA1;

/**
 *  Create a SHA256 string from self
 *
 *  @return Returns the SHA256 NSString from self
 */
- (NSString * _Nullable)SHA256;

/**
 *  Create a SHA512 string from self
 *
 *  @return Returns the SHA512 NSString from self
 */
- (NSString * _Nullable)SHA512;

/**
 *  Check if self is an email
 *
 *  @return Returns YES if it's an email, NO if not
 */
- (BOOL)isEmail;

/**
 *  Check if the given string is an email
 *
 *  @param email The string to be checked
 *
 *  @return Returns YES if it's an email, NO if not
 */
+ (BOOL)isEmail:(NSString * _Nonnull)email;

/**
 *  Encode the given string to Base64
 *
 *  @param string String to encode
 *
 *  @return Returns the encoded string
 */
+ (NSString * _Nonnull)encodeToBase64:(NSString * _Nonnull)string;

/**
 *  Encode the given string to Base64
 *
 *  @return Returns the encoded string
 */
- (NSString * _Nonnull)encodeToBase64;

/**
 *  Decode the given Base64 to string
 *
 *  @param string String to decode
 *
 *  @return Returns the decoded string
 */
+ (NSString * _Nonnull)decodeBase64:(NSString * _Nonnull)string;

/**
 *  Decode the given Base64 to string
 *
 *  @return Returns the decoded string
 */
- (NSString * _Nonnull)decodeBase64;

/**
 *  Conver self to a capitalized string.
 *  Example: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test"
 *
 *  @return Returns the capitalized sentence string
 */
- (NSString * _Nonnull)sentenceCapitalizedString;

/**
 *  Returns a human legible string from a timestamp
 *
 *  @return Returns a human legible string from a timestamp
 */
- (NSString * _Nonnull)dateFromTimestamp;

/**
 *  Encode self to an encoded url string
 *
 *  @return Returns the encoded NSString
 */
- (NSString * _Nonnull)urlEncode DEPRECATED_MSG_ATTRIBUTE("Use -URLEncode");

/**
 *  Encode self to an encoded url string
 *
 *  @return Returns the encoded NSString
 */
- (NSString * _Nonnull)URLEncode;

- (NSString * _Nonnull)urlEncodeWithAllowedCharacters;

/**
 *  Remove double or more duplicated spaces
 *
 *  @return String without additional spaces
 */
- (NSString * _Nonnull)removeExtraSpaces;

/**
 *  Returns a new string containing matching regular expressions replaced with the template string
 *
 *  @param regexString The regex string
 *  @param replacement The replacement string
 *
 *  @return Returns a new string containing matching regular expressions replaced with the template string
 */
- (NSString * _Nonnull)stringByReplacingWithRegex:(NSString * _Nonnull)regexString withString:(NSString * _Nonnull)replacement;

/**
 *  Convert HEX string (separated by space) to "usual" characters string.
 *	Example: "68 65 6c 6c 6f" -> "hello"
 *
 *  @return Readable string
 */
- (NSString * _Nonnull)HEXToString;

/**
 *  Convert string to HEX string.
 *	Example: "hello" -> "68656c6c6f"
 *
 *  @return HEX string
 */
- (NSString * _Nonnull)stringToHEX;

/**
 *  Used to create an UUID as NSString
 *
 *  @return Returns the created UUID string
 */
+ (NSString * _Nonnull)generateUUID;

/**
 *  一个label现实多种字体、颜色时使用
 *
 *  @return Returns the created UUID string
 */
+(NSMutableAttributedString * _Nonnull)setLabelText:(NSString * _Nonnull)text withAttribute:(NSArray * _Nonnull)attributeArr;
@end
