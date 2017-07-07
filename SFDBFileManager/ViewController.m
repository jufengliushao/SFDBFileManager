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
    NSObject *obj = [[NSObject alloc] init];
    [[SFDBManager shareInstance] sf_inseartData:@[obj] intoTable:@"a"];
    NSLog(@"%@", [[SFFileManager shareInstance] sf_getDocumentsPath]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
