//
//  SFDBBase.m
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/9.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFDBBase.h"

@interface SFDBBase(){
    dispatch_queue_t queue;
}

@end

@implementation SFDBBase
- (instancetype)init{
    if (self = [super init]) {
        queue = dispatch_queue_create("sfdbQueue.read.write.com", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)queue_writePlist:(void(^)())operating{
    dispatch_barrier_sync(queue, ^{
        operating();
    });
}

- (void)queue_readData:(void(^)())operating{
    dispatch_async(queue, ^{
        operating();
    });
}
@end
