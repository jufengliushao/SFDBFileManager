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

#import "StudentModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    StudentModel *obj = [[StudentModel alloc] init];
    obj.name = @"xiaoming";
    obj.gender = @"f";
    obj.stu_no = @"llll";
    [[SFDBManager shareInstance] sf_inseartData:@[obj] intoTable:@"a"];
    NSLog(@"%@", [[SFFileManager shareInstance] sf_getDocumentsPath]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
