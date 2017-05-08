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

#pragma mark - private method
- (void)readPlistData{
    db_table_names = [NSMutableDictionary dictionaryWithContentsOfFile:plist_path];
}

- (BOOL)haveKeyName:(NSString *_Nullable)tableName{
    if (tableName) {
        if ([db_table_names.allKeys containsObject:tableName]) {
            return YES;
        }
    }
    return NO;
}

- (void)plist_addData:(NSString *_Nonnull)key{
    [db_table_names setObject:key forKey:key];
    [db_table_names writeToFile:plist_path atomically:YES];
}

@end
