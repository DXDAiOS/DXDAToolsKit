//
//  SearchCacheManager.h
//  RxdaApp
//自定义缓存搜索记录

//  Created by Fady on 16/5/5.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchCacheManager : NSObject

//缓存搜索的数组
+(void)AddSearchCache :(NSString *)searchText withKeyName:(NSString *)keyName;
//读取历史搜索记录
+(NSArray *)readCachewithKeyName:(NSString *)keyName;
//清除缓存数组
+(void)removeAllCachewithKeyName:(NSString *)keyName;

@end
