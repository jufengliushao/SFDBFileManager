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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SFDBManager shareInstance] db_open];
    [[SFDBManager shareInstance] bd_sql:@"create table User (id_User long, name varchar(100))" complete:^(int complete, char *erro) {
        NSLog(@"%d", complete);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
