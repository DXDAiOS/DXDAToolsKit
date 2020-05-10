//
//  NSString+DXDAAddressStr.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/6/13.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSString+DXDAAddressStr.h"

@implementation NSString (DXDAAddressStr)

+ (NSString *)DXDAAddressStr:(NSString *)str
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z.-]" options:0 error:NULL];
    NSString *result = [regular stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
    NSLog(@"%@",result);
    
    NSString *pureNumbers = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    
    NSLog(@"%@",pureNumbers);
//    NSString *str1 = [NSString stringWithFormat:@"%ld",(long)[[[[str stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    return pureNumbers;
}

@end
