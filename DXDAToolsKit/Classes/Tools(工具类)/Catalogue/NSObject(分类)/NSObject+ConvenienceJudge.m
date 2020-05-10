//
//  NSObject+ConvenienceJudge.m
//  NewApp3.0
//
//  Created by DXDA on 2017/4/26.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSObject+ConvenienceJudge.h"

@implementation NSObject (ConvenienceJudge)

#pragma mark - 判断是否可以跳转
+(BOOL)judgeCurrentControllerCanPush:(NSString *)controllerTitle {
    if ([controllerTitle containsString:@"账单"] ||
        [controllerTitle containsString:@"款单"] ||
        [controllerTitle containsString:@"报表"]) {
        
        return YES;
    }
    return NO;
}

+(BOOL)workItems_judgeCurrentControllerCanPush:(NSString *)controllerTitle {
    if ([controllerTitle containsString:@"销售"] ||
        [controllerTitle containsString:@"采购"]) {
        return YES;
    }
    return NO;
}

@end
