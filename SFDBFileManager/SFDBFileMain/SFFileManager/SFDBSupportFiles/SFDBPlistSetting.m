//
//  SFDBPlistSetting.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/8.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBPlistSetting.h"
#import "SFFileManager.h"
#define kDATA_BASE_TABLE_NAME @"sfdbTable.plist"

typedef NS_ENUM (NSInteger, SF_TABLE_OPERAT_TYPE){
    SF_CREATE_TABLE,
    SF_DROP_TABLE,
    SF_NONE_TABLE
};

@interface SFDBPlistSetting(){
    NSMutableDictionary *db_table_names;
    NSString *plist_path;
}
@end

SFDBPlistSetting *plist_setting = nil;

@implementation SFDBPlistSetting

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!plist_setting) {
            plist_setting = [[SFDBPlistSetting alloc] init];
        }
    });
    return plist_setting;
}

- (instancetype)init{
    if (self = [super init]) {
        plist_path = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:kDATA_BASE_TABLE_NAME];
        [self plist_exist];
    }
    return self;
}

#pragma mark - public method
- (void)plist_exist{
    if (![[SFFileManager shareInstance] sf_fileExist:plist_path]) {
        // file not exist, copy the file
        [[SFFileManager shareInstance] sf_copyBundleFile:kDATA_BASE_TABLE_NAME toPath:[[SFFileManager shareInstance] sf_getDocumentsPath]];
    }else{
        // read the plist data
        [self readPlistData];
    }
}

- (void)plist_saveORdeleteTableName:(NSString *_Nullable)sql{
    
    NSString *table_name = [self plist_returnTableName:sql];
    if (!table_name) {
        return;
    }
    
    if (![self haveKeyName:table_name]) {
        [self plist_addData:table_name];
    }else{
        [self plist_deleteData:table_name];
    }
}

- (NSString *)plist_returnTableName:(NSString *_Nullable)sql{
    NSString *table_name = nil;
    NSString *upSQL = [sql uppercaseString];
    if ([upSQL containsString:@"TABLE"]) {
        NSArray *sub = [sql componentsSeparatedByString:@" "];
        __block NSUInteger inde = -1;
        [sub enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj uppercaseString] isEqualToString:@"TABLE"]) {
                inde = idx + 1;
            }
            if (idx == inde) {
                *stop = YES;
            }
        }];
        table_name = inde < sub.count ? sub[inde] : nil;
    }
    return table_name;
}

- (void)plist_addData:(NSString *_Nonnull)key{
    [db_table_names setObject:key forKey:key];
    [self resavePlist];
}

- (void)plist_deleteData:(NSString *_Nonnull)key{
    [db_table_names removeObjectForKey:key];
    [self resavePlist];
}
#pragma mark - private method
- (void)readPlistData{
    [self queue_readData:^{
       db_table_names = [NSMutableDictionary dictionaryWithContentsOfFile:plist_path];
    }];
}

- (BOOL)haveKeyName:(NSString *_Nullable)tableName{
    if (tableName) {
        if ([db_table_names.allKeys containsObject:tableName]) {
            return YES;
        }
    }
    return NO;
}

- (void)resavePlist{
    [self queue_writePlist:^{
        [db_table_names writeToFile:plist_path atomically:YES];
    }];
}

- (SF_TABLE_OPERAT_TYPE)isCreateTable:(NSString *_Nonnull)sql{
    NSString *SQL = [sql uppercaseString];
    if ([SQL containsString:@"DROP"]) {
        return SF_DROP_TABLE;
    }else if ([SQL containsString:@"CREATE"]){
        return SF_CREATE_TABLE;
    }
    return SF_NONE_TABLE;
}
#pragma mark - getter 
- (NSArray *)currentTableNames{
    [self readPlistData];
    return db_table_names.allKeys;
}
@end
