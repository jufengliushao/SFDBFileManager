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
 db-file path
 */
@property (nonatomic, copy, readonly) NSString *_Nonnull dbPath;
/**
 table-names
 */
@property (nonatomic, strong, readonly) NSArray *tableNames;

/**
 open dataBase
 if the .db or .sqlit not exist, the file will be created
 
 @return YES open-success NO open-fail
 */
- (BOOL)db_open;
/**
 clos dataBase

 @return YES open-success NO open-fail
 */
- (BOOL)db_close;

/**
 <#Description#>

 @param sql <#sql description#>
 @param complete <#complete description#>
 */
- (void)db_sql:(NSString *_Nullable)sql complete:(void(^_Nullable)(int complete, char * _Nullable erro))complete;
@end
