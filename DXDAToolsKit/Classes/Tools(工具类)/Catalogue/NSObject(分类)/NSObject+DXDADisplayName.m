//
//  NSObject+DXDADisplayName.m
//  NewApp3.0
//
//  Created by DXDA on 2020/4/7.
//  Copyright © 2020 DXDA. All rights reserved.
//

#import "NSObject+DXDADisplayName.h"



@implementation NSObject (DXDADisplayName)
+(NSString *)APPDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *disN = [NSString stringWithFormat:@"%@-Swift.h",app_Name];
    
    return disN;
}

@end
