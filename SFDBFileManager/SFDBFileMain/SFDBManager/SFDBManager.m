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
    if (!tableName || !model ||  [[SFDBPlistSetting shareInstance] plist_containTableName:tableName]) {
        // 条件不满足 class为空 or 表名为空 or 表明存在
        return;
    }
    
    if (![self returnDbOpen]) {
        // 数据库打开失败
        SFLog(@"数据库打开失败，请检查！");
        return;
    }
    
    NSString *sql = [[SFDBSQL shareInstance] sql_returnTableName:tableName cols:[[[model alloc] init] allPropertyNames]];
    [self queue_writePlist:^{
        if ([_db executeStatements:sql]) {
            [[SFDBPlistSetting shareInstance] plist_saveTableName:tableName];
        }
    }];
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
    NSArray *array = [[SFDBSQL shareInstance] sql_returnInsertTableName:tableName datas:models];
    
    if (![self returnDbOpen]) {
        // 数据库打开失败
        return;
    }
    
    // 插入数据
    [self queue_writePlist:^{
        for (NSString *sql in array) {
            [_db executeUpdate:sql];
        }
    }];
}

- (void)sf_getAllDatas:(NSString *)tableName class:(Class)model complete:(void (^)(BOOL, NSArray * _Nullable))complete{
    if (!tableName || !model ||  ![[SFDBPlistSetting shareInstance] plist_containTableName:tableName]) {
        // 条件不满足 class为空 or 表名为空 or 表名不存在
        return;
    }
    
    if (![self returnDbOpen]) {
        // 数据库打开失败
        return;
    }
    
    [self queue_readData:^{
        FMResultSet *resultSet = [_db executeQuery:[[SFDBSQL shareInstance] sql_returnSelectAll:tableName]];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSArray *properties = [[[model alloc] init] allPropertyNames];
        while ([resultSet next]) {
            id model1 = [[model alloc] init];
            for (NSString *key in properties) {
                [model1 setValue:[resultSet stringForColumn:key] forKey:key];
            }
            [array addObject:model1];
        }
        complete(YES, array);
    }];
    
}

- (void)sf_deleteAllDatas:(NSString *)tableName{
    if (!tableName || ![[SFDBPlistSetting shareInstance] plist_containTableName:tableName]) {
        // 表名为空 or 表名不存在
        return;
    }
    
    if (![self returnDbOpen]) {
        // 数据库打开失败
        return;
    }
    
    [self queue_writePlist:^{
        [_db executeUpdate:[[SFDBSQL shareInstance] sql_returnDeleteAll:tableName]];
    }];
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


/**
 判断数据库是否打开，没有打开，进行打开

 @return <#return value description#>
 */
- (BOOL)returnDbOpen{
    if (!_db.open) {
        return [_db open];
    }
    return YES;
}
@end
