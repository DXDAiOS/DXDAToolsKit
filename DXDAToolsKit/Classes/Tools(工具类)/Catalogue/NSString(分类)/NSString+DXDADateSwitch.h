//
//  NSString+DXDADateSwitch.h
//  NewApp3.0
//
//  Created by Erowin on 17/1/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DXDADateSwitch)

///日期转成当前时间
+(NSString *)stringWithDateSwichTime:(NSString *)dateStr;

#pragma mark - 时间对比
+ (NSString *)formateDate:(NSString *)dateString;


/* 改变部分字符串颜色1 */
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString;

/* 改变部分字符串颜色2 */
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString color:(UIColor *)color;

/* 改变部分字符串颜色3 */
+(NSAttributedString *)changeColorWithString:(NSString *)string firstString:(NSString *)first secondString:(NSString *)second;
+ (BOOL)validateNumber:(NSString*)number;
//某一天，往后的第几天的日期
+(NSString *)getNumberDays:(NSInteger)number dateString:(NSString *)dateString;
@end
