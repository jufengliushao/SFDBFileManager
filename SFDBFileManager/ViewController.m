//
//  ViewController.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/3/16.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "ViewController.h"
#import "SFFileManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = [[SFFileManager shareInstance] sf_getTmpPath];
    NSLog(@"%d---%@", [[SFFileManager shareInstance] sf_createFile:@"a.txt" path:[str stringByAppendingPathComponent:@"d/a.txt"]], str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
