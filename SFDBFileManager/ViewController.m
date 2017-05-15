//
//  ViewController.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/3/16.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "ViewController.h"
#import "SFFileManager.h"
#import "SFDBManager.h"
#import "SFDBSQL.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SFDBManager shareInstance] db_open];
    [[SFDBSQL shareInstance] sql_createTableName:@"a" cols:@{
                                                             @"name": @"varchar(20)",
                                                             @"age": @"int"
                                                             }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
