//
//  SFDBPlistSetting.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/8.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBPlistSetting.h"
#import "SFFileManager.h"

typedef NS_ENUM (NSInteger, SF_TABLE_OPERAT_TYPE){
    SF_NONE_TABLE,
    SF_CREATE_TABLE,
    SF_DROP_TABLE
};

@interface SFDBPlistSetting(){
    NSMutableArray *db_table_names;
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
        plist_path = [[[SFFileManager shareInstance] sf_getDocumentsPath] stringByAppendingPathComponent:SF_PLIST_NAME];
        [self plist_exist];
        [self plist_containTableName:@""];
    }
    return self;
}

#pragma mark - public method
- (void)plist_saveTableName:(NSString *)tableName{
    NSMutableArray *dataArr = [[NSMutableArray alloc] initWithContentsOfFile:plist_path];
    [dataArr addObject:tableName];
    [dataArr writeToFile:plist_path atomically:YES];
}

- (BOOL)plist_containTableName:(NSString *_Nonnull)tableName{
    return [self.currentTableNames containsObject:tableName] ? YES : NO;
}
#pragma mark - private method
- (void)plist_exist{
    if (![[SFFileManager shareInstance] sf_fileExist:plist_path]) {
        // file not exist, copy the file
        [[SFFileManager shareInstance] sf_copyBundleFile:SF_PLIST_NAME toPath:[[SFFileManager shareInstance] sf_getDocumentsPath]];
    }else{
        // read the plist data
        [self readPlistData];
    }
}

- (void)readPlistData{
    db_table_names = [NSMutableArray arrayWithContentsOfFile:plist_path];
}
#pragma mark - getter 
- (NSArray *)currentTableNames{
    [self readPlistData];
    return db_table_names;
}
@end
