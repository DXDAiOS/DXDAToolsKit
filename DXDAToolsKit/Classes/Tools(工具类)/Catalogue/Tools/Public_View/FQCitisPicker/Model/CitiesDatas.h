//
//  CitiesDatas.h
//  DateSelect4.27
//
//  Created by Freedom on 16/4/27.
//  Copyright © 2016年 Freedom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesDatas : NSObject

@property(strong,nonatomic)NSArray *cities;

@property(nonatomic,copy)NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)citiesDatasWithDic:(NSDictionary *)dic;

+(NSArray *)citiesDatas;

@end
