//
//  SFDBPlistSetting.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/8.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBPlistSetting.h"

@interface SFDBPlistSetting(){
    NSDictionary *db_table_name;
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

@end
