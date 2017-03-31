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

- (NSString *)sf_getBlunleFilePath:(NSString *_Nonnull)fileName type:(NSString *_Nullable)type{
    return [self getBundleFilePath:fileName type:type];
}

- (BOOL)sf_copyBundleFile:(NSString *_Nonnull)file toPath:(NSString *_Nonnull)path{
    NSString *exist = [path stringByAppendingPathComponent:file];
    NSString *bundleStr = [self sf_getBlunleFilePath:file type:nil];
    if (!bundleStr) {
        return NO;
    }
    if(![self sf_fileExist:exist]){
        NSError *error;
        return [[NSFileManager defaultManager] copyItemAtPath:bundleStr toPath:exist error:&error];
    }
    return YES;
}

- (BOOL)sf_fileExist:(NSString *_Nullable)path{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (BOOL)sf_copyFilePath:(NSString *_Nonnull)filePath toPath:(NSString *_Nonnull)toPath{
    BOOL isfileName = NO;
    if ([[self returnFileNameFromPath:filePath] isEqualToString:[self returnFileNameFromPath:toPath]]) {
        isfileName = YES;
    }
    NSString *finalPath = isfileName ? toPath : [toPath stringByAppendingPathComponent:[self returnFileNameFromPath:filePath]];
    if (![self sf_fileExist:filePath]) {
        // 文件不存在
        return NO;
    }
    if (![self sf_fileExist:finalPath]) {
        NSError *error;
        return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:finalPath error:&error];
    }
    return YES;
}

- (BOOL)sf_deleteFileWithPath:(NSString *_Nullable)filePath{
    if (![self sf_fileExist:filePath]) {
        // 文件不存在
        return YES;
    }
    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
}
#pragma mark - private method
- (NSString *)getBundleFilePath:(NSString *_Nonnull)fileName type:(NSString *_Nullable)fileType{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
}

- (NSString *)returnFileNameFromPath:(NSString *)path{
    NSArray *arr = [path componentsSeparatedByString:@"/"];
    NSString *fileName = [arr.lastObject length] > 0 ? arr.lastObject : ((arr.count > 1) ? arr[arr.count - 2] : nil);
    return fileName;
}
@end
