//
//  SFDBManager.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/4/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBBase.h"

@interface SFDBManager : SFDBBase
+ (instancetype _Nonnull)shareInstance;
/**
 * db-file path
 * 数据库文件路径
 */
@property (nonatomic, copy, readonly) NSString *_Nonnull sf_dbPath;

/**
 * table-names
 * 表名数组
 */
@property (nonatomic, strong, readonly) NSArray *_Nullable sf_tableNames;

/**
 open dataBase
 if the .db or .sqlit not exist, the file will be created
 */
- (void)sf_db_open;
/**
 clos dataBase
 */
- (void)sf_db_close;

/**
 add data with model
 * 表格不存在创建表格 按照第一个model进行创建列
 * 数据数组为空，不创建表格
 * models 需要一致
 
 @param models models -> nsobject
 @param tableName tableName
 */
- (void)sf_inseartData:(NSArray <__kindof NSObject *>*_Nullable)models intoTable:(NSString *_Nonnull)tableName;
@end
