//
//  NSObject+SFObject.m
//  ChannelManager
//
//  Created by cnlive-lsf on 2017/6/28.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "NSObject+SFObject.h"
#import <objc/runtime.h>
@implementation NSObject (SFObject)
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    return allNames;
}

- (NSDictionary *)getAllIvers{
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    return @{
             SFOBJECT_SUMS_KEY: @(methodCount),
             SFOBJECT_IVERS_KEY: [NSValue valueWithBytes:&ivars objCType:@encode(Ivar)]
             };
}

- (Class)returnModelClass{
    NSString *str = [NSString stringFromChar:object_getClassName(self)];
    return [str stringToClass];
}
@end
