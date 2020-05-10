//
//  SVProgressHUD+Exel.m
//  FQKuaiYi1.0
//
//  Created by Freedom on 16/7/6.
//  Copyright © 2016年 Freedom. All rights reserved.
//

#import "SVProgressHUD+Exel.h"

@implementation SVProgressHUD (Exel)
// 设置超时时间
const NSTimeInterval overTime = 1.0;

+(void)showSuccessWithTitle:(NSString *)title
{
    [SVProgressHUD showSuccessWithStatus:title];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(overTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+(void)showErrorWithTitle:(NSString *)title
{
    [SVProgressHUD showErrorWithStatus:title];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(overTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}



@end
