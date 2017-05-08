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
    if ([self db_open]) {
        // db-opening
        
    }
    return YES;
}

- (void)bd_sql:(NSString *_Nullable)sql complete:(void(^)(int complete, char *erro))complete{
    char *error;
    int com = -1; // db open fail
    if ([self db_open]) {
        // db-opening
        if (sql) {
            const char *sql_char = [sql UTF8String];
            com = sqlite3_exec(_db, sql_char, NULL, NULL, &error);
            if (com == SQLITE_OK) {
                [self returnTableName:sql];
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

- (void)existDBTablePlist{
    NSString *tab_name_plist = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:kDATA_BASE_TABLE_NAME];
    NSLog(@"%@", tab_name_plist);
    if (![[SFFileManager shareInstance] sf_fileExist:tab_name_plist]) {
        // file not exist, copy the file
        [[SFFileManager shareInstance] sf_copyBundleFile:kDATA_BASE_TABLE_NAME toPath:[[SFFileManager shareInstance] sf_getDocumentsPath]];
    }else{
        // read the plist data
        _dbDit = [NSMutableDictionary dictionaryWithContentsOfFile:tab_name_plist];
    }
}

- (NSString *)dbPath{
    return _filePath;
}

- (BOOL)isexistTable:(NSString *_Nonnull)tableName{
    return [_dbDit.allKeys containsObject:tableName] ? YES : NO;
}

- (NSString *)returnTableName:(NSString *_Nullable)sql{
    NSString *table_name = nil;
    NSString *upSQL = [sql uppercaseString];
    if ([upSQL containsString:@"TABLE"]) {
        NSArray *sub = [sql componentsSeparatedByString:@" "];
        __block NSUInteger inde = -1;
        [sub enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj uppercaseString] isEqualToString:@"TABLE"]) {
                inde = idx + 1;
            }
            if (idx == inde) {
                *stop = YES;
            }
        }];
        table_name = inde < sub.count ? sub[inde] : nil;
    }
    return table_name;
}

- (void)saveORdeleteTableName:(NSString *_Nullable)sql{
   NSString *tab_name_plist = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:kDATA_BASE_TABLE_NAME];
    
    NSString *tabel_name = [self returnTableName:sql];
    if (!tabel_name) {
        return;
    }
    
    if (![_dbDit.allKeys containsObject:[self returnTableName:sql]]) {
        
    }
}
@end
