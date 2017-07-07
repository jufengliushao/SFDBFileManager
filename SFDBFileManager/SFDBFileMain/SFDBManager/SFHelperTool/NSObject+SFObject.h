//
//  NSObject+SFObject.h
//  ChannelManager
//
//  Created by cnlive-lsf on 2017/6/28.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define SFOBJECT_IVERS_KEY @"SFOBJECT_IVERS_KEY"
#define SFOBJECT_SUMS_KEY @"SFOBJECT_SUMS_KEY"

@interface NSObject (SFObject)
/**
 获取当前对象所有属性名

 @return 数组
 */
- (NSArray *)allPropertyNames;

/**
 返回所有对象Ivars

 @return ivars
 */
- (NSDictionary *)getAllIvers;

/**
 返回对象的class
 
 @return class
 */
- (Class)returnModelClass;
@end
