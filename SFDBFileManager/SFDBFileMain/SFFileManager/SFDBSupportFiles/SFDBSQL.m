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


@end
