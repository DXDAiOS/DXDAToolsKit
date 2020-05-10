//
//  NSObject+Transform.m
//  x_App
//
//  Created by DXDA on 2017/7/19.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import "NSObject+Transform.h"

@implementation NSObject (Transform)

#pragma mark - 保留小数点 2位
+(CGFloat)floatType:(CGFloat)value {
    
//    NSString *switchStr = [NSString stringWithFormat:@"%.2f",value];
//    return switchStr.doubleValue;
    return value;
}

+(CGFloat)switchToFloatType:(id)value {
    NSString *switchStr = [NSString stringWithFormat:@"%@",value];
    CGFloat tempValue = [NSString stringWithFormat:@"%.2f",switchStr.floatValue].floatValue;
    return tempValue;
}

@end
