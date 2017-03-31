//
//  SFFileManager.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/3/16.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFFileManager.h"

SFFileManager *manager = nil;

@implementation SFFileManager
#pragma mark share instance
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[SFFileManager alloc] init];
        }
    });
    return manager;
}

#pragma mark - public method
- (NSString *)sf_getHomeDirectoryPath{
    return NSHomeDirectory();
}

- (NSString *)sf_getDocumentsPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)sf_getLibraryPath{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)sf_getCachePath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)sf_getTmpPath{
    return NSTemporaryDirectory();
}
@end
