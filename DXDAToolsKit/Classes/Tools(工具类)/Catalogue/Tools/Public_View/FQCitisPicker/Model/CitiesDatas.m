//
//  CitiesDatas.m
//  DateSelect4.27
//
//  Created by Freedom on 16/4/27.
//  Copyright © 2016年 Freedom. All rights reserved.
//

#import "CitiesDatas.h"

@implementation CitiesDatas


-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)citiesDatasWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}

+(NSArray *)citiesDatas
{
    NSArray *datas=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil]];
    
    NSMutableArray *citiesDatas=[NSMutableArray array];
    
    for (NSDictionary *dic in datas)
    {
        [citiesDatas addObject:[CitiesDatas citiesDatasWithDic:dic]];
    }
    
    return citiesDatas;
}

@end
