//
//  SFDBManager.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/4/11.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBManager.h"
#import <sqlite3.h>
@interface SFDBManager(){
    NSMutableDictionary *_dbDit;
}
@end

SFDBManager *m = nil;

@implementation SFDBManager
+ (instancetype _Nonnull)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!m) {
            m = [[SFDBManager alloc] init];
        }
    });
    return m;
}

- (instancetype)init{
    if (self = [super init]) {
        _dbDit = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

#pragma mark - public method
- (BOOL)db_openWithDocPath:(NSString *)dbPath{
    return YES;
}

- (BOOL)db_close{
    return YES;
}
@end
