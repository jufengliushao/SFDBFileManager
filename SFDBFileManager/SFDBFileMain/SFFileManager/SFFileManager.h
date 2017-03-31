//
//  SFFileManager.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/3/16.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFFileManager : NSObject
/**
 init method
 单利初始化方法
 @return instancetype
 */
+(instancetype)shareInstance;

/**
 return home path
 返回沙盒主目录
 @return NSString
 */
- (NSString *)sf_getHomeDirectoryPath;

/**
 return documents path
 返回documents路径

 @return NSString
 */
- (NSString *)sf_getDocumentsPath;

/**
 return Library path
 返回Liarary路径
 @return NSString
 */
- (NSString *)sf_getLibraryPath;

/**
 return Caches path
 返回Caches路径
 @return NSString
 */
- (NSString *)sf_getCachePath;

/**
 return Tmp path
 返回tmp路径
 @return NSString
 */
- (NSString *)sf_getTmpPath;
@end
