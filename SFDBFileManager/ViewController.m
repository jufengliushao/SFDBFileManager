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
    
    StudentModel *obj1 = [[StudentModel alloc] init];
    obj1.name = @"xiaoming1";
    obj1.gender = @"f";
    obj1.stu_no = @"llll";
    
    StudentModel *obj2 = [[StudentModel alloc] init];
    obj2.name = @"xiaoming2";
    obj2.gender = @"f";
    obj2.stu_no = @"llll";
    
    StudentModel *obj3 = [[StudentModel alloc] init];
    obj3.name = @"xiaoming3";
    obj3.gender = @"f";
    obj3.stu_no = @"llll";
    [[SFDBManager shareInstance] sf_inseartData:@[obj, obj1, obj2, obj3] intoTable:@"a"];
    
    [[SFDBManager shareInstance] sf_getAllDatas:@"a" class:[StudentModel class] complete:^(BOOL success, NSArray * _Nullable models) {
        NSLog(@"%@", models);
    }];
    NSLog(@"%@", [[SFFileManager shareInstance] sf_getDocumentsPath]);
    
    [[SFDBManager shareInstance] sf_deleteAllDatas:@"a"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
