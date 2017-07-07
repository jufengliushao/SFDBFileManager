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
 create table

 @param tableName   string    table-name
 @param             cols       cols keys
                        {@"name":@"varchar(20)"}
 @return YES complete
 */
- (BOOL)sql_createTableName:(NSString *_Nonnull)tableName cols:(NSDictionary *_Nonnull)cols;

/**
 delete table

 @param tableName table-name
 @return <#return value description#>
 */
- (BOOL)sql_dropTable:(NSString *_Nonnull)tableName;
@end
