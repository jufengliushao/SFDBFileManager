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

#define kDATA_BASE_NAME @"sfdb.db"
#define kDATA_BASE_TABLE_NAME @"sfdbTable.plist"

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
        [self existDBTablePlist];
    }
    return self;
}

#pragma mark - public method
- (BOOL)db_open{
    if (!_db) {
        if (sqlite3_open([_filePath UTF8String], &_db) == SQLITE_OK) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (BOOL)db_close{
    if(_db){
        return sqlite3_close(_db) == SQLITE_OK ? YES : NO;
    }
    return YES;
}

- (BOOL)db_createSQLTable:(NSString *_Nullable)tableName andColumns:(NSDictionary *_Nullable)colDic{
    return YES;
}
#pragma mark private method
- (void)createDBFile:(NSString *_Nullable)dbPath{
    if (_filePath) {
        [[SFFileManager shareInstance] sf_createFile:kDATA_BASE_NAME path:_filePath];
    }
}

- (void)existDBTablePlist{
    NSString *tab_name_plist = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:kDATA_BASE_TABLE_NAME];
    NSLog(@"%@", tab_name_plist);
    if (![[SFFileManager shareInstance] sf_fileExist:tab_name_plist]) {
        // file not exist, create the file
        [[SFFileManager shareInstance] sf_createFile:tab_name_plist path:kDATA_BASE_TABLE_NAME];
    }
}

- (NSString *)dbPath{
    return _filePath;
}
@end
