//
//  NSString+jsonToDic.m
//  RxdaApp
//
//  Created by Erowin on 16/10/12.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "NSString+jsonToDic.h"

@implementation NSString (jsonToDic)

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSString*)hexStringForData:(NSData*)data

{
    
    if (data == nil) {
        
        return nil;
        
    }
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        
        [hexString appendFormat:@"%02x", *p++];
        
    }
    
    return hexString;
}

+ (NSString *)arrayToJSONString:(NSArray *)array
{
    if (array.count == 0) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
