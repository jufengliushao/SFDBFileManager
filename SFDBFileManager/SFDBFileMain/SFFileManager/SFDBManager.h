//
//  SFDBManager.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/4/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFDBManager : NSObject
+ (instancetype _Nonnull)shareInstance;

/**
 db-file path
 */
@property (nonatomic, copy, readonly) NSString *_Nonnull dbPath;

/**
 open dataBase
 if the .db or .sqlit not exist, the file will be created
 
 @return YES open-success NO open-fail
 */
- (BOOL)db_open;
- (BOOL)db_close;

/**
 <#Description#>

 @param sql <#sql description#>
 @param complete <#complete description#>
 */
- (void)bd_sql:(NSString *_Nullable)sql complete:(void(^)(int complete, char *erro))complete;
@end
