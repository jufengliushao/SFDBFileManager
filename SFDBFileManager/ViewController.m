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
    [[SFFileManager shareInstance] sf_removeFilesWithExtension:@"jpg" atPath:str];
    NSLog(@"%@", str);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
