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

/**
 return blunle file path

 @param fileName file name
 @param type file type
 @return NSString
 */
- (NSString *)sf_getBlunleFilePath:(NSString *_Nonnull)fileName type:(NSString *_Nullable)type;

/**
 copy bundle file to path
 拷贝bundle文件到指定路径
 @param file 文件名称和类型
 @param path 指定目录
 @return YES 完成 NO失败
 */
- (BOOL)sf_copyBundleFile:(NSString *_Nonnull)file toPath:(NSString *_Nonnull)path;

/**
 the file is extise in this path

 @param path <#path description#>
 @return <#return value description#>
 */
- (BOOL)sf_fileExist:(NSString *_Nullable)path;
@end
