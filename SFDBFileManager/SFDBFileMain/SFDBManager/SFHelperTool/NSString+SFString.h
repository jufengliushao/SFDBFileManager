//
//  NSString+SFString.h
//  ChannelManager
//
//  Created by cnlive-lsf on 2017/6/28.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SFString)
/**
 char -> string

 @param chars chars
 @return string
 */
+ (NSString *)stringFromChar:(const char *)chars;

/**
 string -> char

 @return char *
 */
- (const char *)stringToChar;

/**
 将string的内容转换成class

 @return class
 */
- (Class)stringToClass;

/**
 去掉第一个字符串

 @return self
 */
- (NSString *)cutFirstCharacter;

/**
 将字符串进行base64编码

 @return self
 */
- (NSString *)base64EncodedString;

/**
 将base64转换成字符串

 @return self
 */
- (NSString *)base64DecodedString;
@end
