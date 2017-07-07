//
//  NSString+SFString.m
//  ChannelManager
//
//  Created by cnlive-lsf on 2017/6/28.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "NSString+SFString.h"

@implementation NSString (SFString)
+ (NSString *)stringFromChar:(const char *)chars{
    return [[NSString alloc] initWithCString:chars encoding:NSASCIIStringEncoding];
}

- (const char *)stringToChar{
    return [self cStringUsingEncoding:NSASCIIStringEncoding];
}

- (Class)stringToClass{
    return NSClassFromString(self);
}

- (NSString *)cutFirstCharacter{
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
}

- (NSString *)base64EncodedString{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
