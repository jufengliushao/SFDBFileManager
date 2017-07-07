//
//  SFDBSQL.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBSQL.h"
#import "SFDBManager.h"
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
- (NSString *)sql_returnTableName:(NSString *)tableName cols:(NSArray *)cols{
    NSString *sql = [NSString stringWithFormat:@"create table %@(", tableName];
    
    for (NSString *colds in cols) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" %@ text,", colds]];
    }
    
    sql = [sql stringByReplacingCharactersInRange:NSMakeRange(sql.length-1, 1) withString:@")"];
    
    return sql;
}

#pragma mark - private method
- (__kindof NSString *_Nullable)returnCreateTableSQL:(NSString *_Nonnull)tb keys:(NSDictionary *_Nonnull)keys{
    NSString *sql = [NSString stringWithFormat:@"create table %@", tb];
    
    return [NSString stringWithFormat:@"%@%@", sql, [self returncols:keys]];
}

- (__kindof NSString *_Nonnull)returncols:(NSDictionary *_Nonnull)dic{
    NSArray *key = dic.allKeys;
    NSMutableString *cols = [NSMutableString string];
    
    for (NSString *col in key) {
        [cols appendString:[NSString stringWithFormat:@" %@ %@, ", col, dic[col]]];
    }
    
    [cols deleteCharactersInRange:NSMakeRange(cols.length - 2, 2)]; // delete last ,
    [cols insertString:@" (" atIndex:0]; // add (
    [cols insertString:@")" atIndex:cols.length]; // add )
    return cols;
}
@end