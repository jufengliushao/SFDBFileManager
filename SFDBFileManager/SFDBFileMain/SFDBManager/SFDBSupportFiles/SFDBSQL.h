//
//  SFDBSQL.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBBase.h"

@interface SFDBSQL : SFDBBase

+ (instancetype _Nonnull )shareInstance;
/**
 返回创建表的sql

 @param tableName 表名
 @param cols 列字段数组
 @return sql
 */
- (NSString *_Nullable)sql_returnTableName:(NSString *_Nonnull)tableName cols:(NSArray *_Nonnull)cols;

/**
 返回插入sql语句数组

 @param tableName 表名
 @param datas 数据
 @return sqls
 */
- (NSMutableArray <NSString *>*_Nullable)sql_returnInsertTableName:(NSString *_Nonnull)tableName datas:(__kindof NSArray <__kindof NSObject *>*_Nonnull)datas;

/**
 delete table

 @param tableName table-name
 @return YES
 */
- (BOOL)sql_dropTable:(NSString *_Nonnull)tableName;
@end
