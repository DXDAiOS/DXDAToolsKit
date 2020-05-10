//
//  NSMutableArray+DXDAAddressArr.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/6/13.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSMutableArray+DXDAAddressArr.h"

@implementation NSMutableArray (DXDAAddressArr)

+ (NSMutableArray *)DXDAAddressArr:(NSArray *)arr
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    for (NSString *str in arr) {
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z.-]" options:0 error:NULL];
        NSString *result = [regular stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
        NSLog(@"%@",result);
        
        NSString *pureNumbers = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
        
        NSLog(@"%@",pureNumbers);
        [a addObject:pureNumbers];
    }
    return a;
}

@end
