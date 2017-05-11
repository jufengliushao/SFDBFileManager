//
//  SFDBPlistSetting.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/8.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBBase.h"

@interface SFDBPlistSetting : SFDBBase
+ (instancetype _Nonnull )shareInstance;
/**
 save or delete plist key

 @param sql <#sql description#>
 */
- (void)plist_saveORdeleteTableName:(NSString *_Nullable)sql;

/**
 table-names
 */
@property (nonatomic, strong, readonly) NSArray *_Nullable currentTableNames;
@end
