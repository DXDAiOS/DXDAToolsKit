//
//  iCloudManager.h
//  NewApp3.0
//
//  Created by DXDA on 2019/8/9.
//  Copyright © 2019 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^downloadBlock)(id obj);
@interface iCloudManager : NSObject
+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;
@end

NS_ASSUME_NONNULL_END
