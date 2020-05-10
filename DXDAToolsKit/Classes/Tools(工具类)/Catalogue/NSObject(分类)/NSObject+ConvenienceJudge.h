//
//  NSObject+ConvenienceJudge.h
//  NewApp3.0
//
//  Created by DXDA on 2017/4/26.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ConvenienceJudge)

+(BOOL)judgeCurrentControllerCanPush:(NSString *)controllerTitle;

+(BOOL)workItems_judgeCurrentControllerCanPush:(NSString *)controllerTitle;

@end
