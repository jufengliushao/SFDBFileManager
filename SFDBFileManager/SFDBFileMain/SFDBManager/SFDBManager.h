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
 创建表
 create the table-name
 
 * only support to create once with the same table-name
 * 仅支持一次创建，后序无法添加，如果需要添加请先删除后操作
 
 @param tableName table-name
 @param model model 对应的数据表格的model
 */
- (void)sf_createTable:(NSString *_Nonnull)tableName modelClass:(Class _Nonnull)model;

/**
 add data with model
 * 表格不存在创建表格 按照第一个model进行创建列
 * 数据数组为空，不创建表格
 * models 需要一致
 
 @param models models -> nsobject
 @param tableName tableName
 */
- (void)sf_inseartData:(NSArray <__kindof NSObject *>*_Nullable)models intoTable:(NSString *_Nonnull)tableName;


/**
 select all datas from table

 @param tableName 表名
 @param model 需要转化成的model的class
 @param complete 完成回调
 */
- (void)sf_getAllDatas:(NSString *_Nonnull)tableName class:(Class _Nullable)model complete:(void(^_Nullable)(BOOL success, NSArray *_Nullable models))complete;
@end
