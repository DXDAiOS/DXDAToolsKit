//
//  NSString+jsonToDic.h
//  RxdaApp
//
//  Created by Erowin on 16/10/12.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (jsonToDic)

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (NSString*)hexStringForData:(NSData*)data;

+ (NSString *)arrayToJSONString:(NSArray *)array;

@end
