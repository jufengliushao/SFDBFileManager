//
//  SFDBPlistSetting.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/8.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBBase.h"

@interface SFDBPlistSetting : SFDBBase
/**
 初始化方法
 init-method

 @return SFDBPlistSetting
 */
+ (instancetype _Nonnull )shareInstance;

/**
 添加表名
 add table
 
 @param tableName table-name
 */
- (void)plist_saveTableName:(NSString *_Nonnull)tableName;

/**
 table-names
 */
@property (nonatomic, strong, readonly) NSArray *_Nullable currentTableNames;

/**
 return table-name is exist

 @param tableName tableName
 @return YES NO
 */
- (BOOL)plist_containTableName:(NSString *_Nonnull)tableName;
@end
