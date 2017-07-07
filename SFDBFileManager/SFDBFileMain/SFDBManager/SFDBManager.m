//
//  SFDBManager.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/4/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBManager.h"
#import "SFFileManager.h"
#import "SFDBPlistSetting.h"
#import "FMDB.h"
#import "SFDBSQL.h"

@interface SFDBManager(){
    FMDatabase *_db;
    NSString *_db_filePath; // 数据库文件地址
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
        _db_filePath = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:SF_DATABASE_NAME];
        [self createDBFile]; // 创建数据库文件
        _db = [FMDatabase databaseWithURL:[NSURL URLWithString:_db_filePath]];
        [_db open];
    }
    return self;
}

#pragma mark - public method
/**
 数据库打开
 */
- (void)sf_db_open{
    if (!_db.open) {
        [_db open];
    }
}

/**
 数据库关闭
 */
- (void)sf_db_close{
    if(_db.open){
        [_db close];
    }
}

- (void)sf_createTable:(NSString *)tableName modelClass:(Class)model{
    if (!tableName || !model) {
        // 条件不满足 class为空 or 表名为空
        return;
    }
    
    NSString *sql = [[SFDBSQL shareInstance] sql_returnTableName:tableName cols:[[[model alloc] init] allPropertyNames]];
    NSLog(@"%@", sql);
}

- (void)sf_inseartData:(NSArray<__kindof NSObject *> *)models intoTable:(NSString *)tableName{
    
    if (!models.count || !tableName) {
        // 条件不满足 数据为空 or 表名为空
        return;
    }
    
    if (![[SFDBPlistSetting shareInstance] plist_containTableName:tableName]) {
        // no exist the table-name
        [self sf_createTable:tableName modelClass:[models[0] class]]; // create table
    }
}


#pragma mark private method
/**
 创建db文件
 */
- (void)createDBFile{
    if(_db_filePath){
        [[SFFileManager shareInstance] sf_createFile:SF_DATABASE_NAME path:_db_filePath];
    }
}

- (NSString *)dbPath{
    return _db_filePath;
}

- (NSArray *)tableNames{
    return [SFDBPlistSetting shareInstance].currentTableNames;
}
@end
