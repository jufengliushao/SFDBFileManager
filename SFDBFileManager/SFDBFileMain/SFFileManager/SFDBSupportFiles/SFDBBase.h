//
//  SFDBBase.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/5/9.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFDBBase : NSObject
- (void)queue_writePlist:(void(^)())operating;
- (void)queue_readData:(void(^)())operating;
@end
