//
//  DXDAMark.m
//  x_App
//
//  Created by 东信达 on 2017/6/30.
//  Copyright © 2017年 SimpleTable. All rights reserved.
//

#import "DXDAMark.h"

@implementation DXDAMark

//直接收款：Direct
//预收款、预付款：Pre
//其他：Bill

#pragma mark -  PayType
+ (NSString *)PayTypeName:(NSString *)Mark_PAY_TYPE
{
    NSString *payTypeName = @"";
    if ([Mark_PAY_TYPE isEqualToString:Mark_PAY_TYPE_AS]) {
        payTypeName = @"至傅报支付";
    }
    else if ([Mark_PAY_TYPE isEqualToString:Mark_PAY_TYPE_WS])
    {
        payTypeName = @"微信支付";
    }
    else if ([Mark_PAY_TYPE isEqualToString:Mark_PAY_TYPE_AT])
    {
        payTypeName = @"至傅报支付";
    }
    else if ([Mark_PAY_TYPE isEqualToString:Mark_PAY_TYPE_WT])
    {
        payTypeName = @"微信支付";
    }
    else if ([Mark_PAY_TYPE isEqualToString:Mark_PAY_TYPE_B])
    {
        payTypeName = @"银联支付";
    }
    else if ([Mark_PAY_TYPE isEqualToString:Mark_PAY_TYPE_C])
    {
        payTypeName = @"现金支付";
    }
    return payTypeName;

}

@end
