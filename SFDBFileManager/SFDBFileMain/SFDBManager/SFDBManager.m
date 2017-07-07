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
#import "SFDBPlistSetting.h"
#import "FMDB.h"

#define kDATA_BASE_NAME @"sfdb.db"
#define kDATA_BASE_TABLE_NAME @"sfdbTable.plist"

@interface SFDBManager(){
    NSMutableDictionary *_dbDit;
    SFDBBase *_db;
    NSString *_db_filePath; // 数据库文件地址
    NSString *_plist_filePath; // plist 文件地址
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
        [SFDBPlistSetting shareInstance];
    }
    return self;
}

#pragma mark - public method
- (BOOL)sf_db_open{
    if (!_db) {
        if (sqlite3_open([_filePath UTF8String], &_db) == SQLITE_OK) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (BOOL)sf_db_close{
    if(_db){
        return sqlite3_close(_db) == SQLITE_OK ? YES : NO;
    }
    return YES;
}

- (BOOL)db_createSQLTable:(NSString *_Nullable)tableName andColumns:(NSDictionary *_Nullable)colDic{
    if ([self sf_db_open]) {
        // db-opening
        
    }
    return YES;
}

- (void)db_sql:(NSString *_Nullable)sql complete:(void(^)(int complete, char *erro))complete{
    char *error = NULL;
    __block int com = -1; // db open fail
    if ([self sf_db_open]) {
        // db-opening
        if (sql) {
            const char *sql_char = [sql UTF8String];
            [self queue_writePlist:^{
                com = sqlite3_exec(_db, sql_char, NULL, NULL, &error);
            }];
            if (com == SQLITE_OK) {
                [self delievePartmentWithSQL:sql];
            }
        }else{
            com = -2; // sql is null
        }
    }
    complete(com, error);
}
#pragma mark private method
- (void)createDBFile:(NSString *_Nullable)dbPath{
    if (_filePath) {
        [[SFFileManager shareInstance] sf_createFile:kDATA_BASE_NAME path:_filePath];
    }
}

- (NSString *)dbPath{
    return _filePath;
}

- (NSArray *)tableNames{
    return [SFDBPlistSetting shareInstance].currentTableNames;
}

- (void)delievePartmentWithSQL:(NSString *_Nonnull)sql{
    if ([[sql uppercaseString] containsString:@"TABLE"]) {
        // 对table create drop
        [[SFDBPlistSetting shareInstance] plist_saveORdeleteTableName:sql];
    }
}
@end
