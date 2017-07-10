
//
//  SFDBKeys.h
//  SFDBFileManager
//
//  Created by cnlive-lsf on 2017/7/7.
//  Copyright © 2017年 lsf. All rights reserved.
//

#ifndef SFDBKeys_h
#define SFDBKeys_h

#define SF_PLIST_NAME @"SF_PLIST_TABLENAME.plist" /* plist文件名 */
#define SF_DATABASE_NAME @"SFDBChache.db" /* db文件名 */

# define SFLog(fmt, ...) NSLog((@"\n[文件名:%s]\n""[函数名:%s]\n""[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

/**
 __weak  __block
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define BS(blockSelf)  __block __typeof(&*self)blockSelf = self;

#import "NSObject+SFObject.h"
#import "NSString+SFString.h"

#endif /* SFDBKeys_h */
