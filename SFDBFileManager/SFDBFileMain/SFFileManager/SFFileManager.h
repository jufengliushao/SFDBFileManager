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
@end
