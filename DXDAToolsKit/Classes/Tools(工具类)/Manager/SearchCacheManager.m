//
//  SearchCacheManager.m
//  RxdaApp
//自定义缓存搜索记录
//
//  Created by Fady on 16/5/5.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "SearchCacheManager.h"

@implementation SearchCacheManager

//缓存搜索数组
+(void)AddSearchCache :(NSString *)searchText withKeyName:(NSString *)keyName
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSArray *SearchArr = [userDefaultes objectForKey:keyName];

    //取出数组，判断是否为空，为空则创建数组
    if (SearchArr.count == 0) {
        SearchArr = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [SearchArr mutableCopy];
    BOOL flag = YES;
    for (NSString*str in searTXT) {
        if ([searchText isEqualToString:str]||[searchText isEqualToString:@""]) {
            flag = NO;
        }
    }
    if (flag) {
        [searTXT addObject:searchText];
    }
    if(searTXT.count > 5)
    {
        [searTXT removeObjectAtIndex:0];
    }
    //将数据存储到NSUserDefaults中
    [userDefaultes setObject:searTXT forKey:keyName];
    [userDefaultes synchronize];
}


//读取历史搜索记录
+(NSArray *)readCachewithKeyName:(NSString *)keyName
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSArray * myArray = [userDefaultes arrayForKey:keyName];
    
    return myArray;
}


//清空历史搜索记录
+(void)removeAllCachewithKeyName:(NSString *)keyName
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:keyName];
    [userDefaults synchronize];
}


@end
