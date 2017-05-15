//
//  SFDBSQL.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBSQL.h"

@interface SFDBSQL(){
    
}

@end

SFDBSQL *sql = nil;

@implementation SFDBSQL
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sql) {
            sql = [[SFDBSQL alloc] init];
        }
    });
    return sql;
}

#pragma mark - public method
- (BOOL)sql_createTableName:(NSString *_Nonnull)tableName cols:(NSDictionary *_Nonnull)cols{
    NSLog(@"%@", [self returnCreateTableSQL:tableName keys:cols]);
    return YES;
}

#pragma mark - private method
- (__kindof NSString *_Nullable)returnCreateTableSQL:(NSString *_Nonnull)tb keys:(NSDictionary *_Nonnull)keys{
    NSArray *key = keys.allKeys;
    NSString *sql = [NSString stringWithFormat:@"create table %@", tb];
    NSMutableString *cols = [NSMutableString string];
    for (NSString *col in key) {
        [cols appendString:[NSString stringWithFormat:@" %@ %@, ", col, keys[col]]];
    }
    [cols deleteCharactersInRange:NSMakeRange(cols.length - 2, 2)];
    [cols insertString:@" (" atIndex:0];
    [cols insertString:@")" atIndex:cols.length];
    return [NSString stringWithFormat:@"%@%@", sql, cols];
}
@end
