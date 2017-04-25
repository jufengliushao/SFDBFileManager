//
//  SFDBManager.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/4/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBManager.h"
#import <sqlite3.h>
#import "SFFileManager.h"

#define kDATA_BASE_NAME @"sfdb.plist"

@interface SFDBManager(){
    NSMutableDictionary *_dbDit;
    sqlite3 *_db;
    NSString *_filePath;
}
@end

SFDBManager *m = nil;

@implementation SFDBManager
+ (instancetype _Nonnull)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!m) {
            m = [[SFDBManager alloc] init];
        }
    });
    return m;
}

- (instancetype)init{
    if (self = [super init]) {
        _dbDit = [NSMutableDictionary dictionaryWithCapacity:0];
        _filePath = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:kDATA_BASE_NAME];
    }
    return self;
}

#pragma mark - public method
- (BOOL)db_open{
    if (_db) {
        sqlite3_open([_filePath UTF8String], &_db);
    }
    return YES;
}

- (BOOL)db_close{
    return YES;
}

#pragma mark private method
- (void)createDBInfoPlist:(NSString *_Nullable)dbPath{
    if (_filePath) {
        [[SFFileManager shareInstance] sf_createFile:kDATA_BASE_NAME path:_filePath];
    }
}

- (NSString *)dbPath{
    return _filePath;
}
@end
