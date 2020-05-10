//
//  NSString+DXDADateSwitch.m
//  NewApp3.0
//
//  Created by Erowin on 17/1/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSString+DXDADateSwitch.h"

@implementation NSString (DXDADateSwitch)

///日期转成当前时间
+(NSString *)stringWithDateSwichTime:(NSString *)dateStr
{
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags=NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit| NSWeekdayCalendarUnit;
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
      NSString *severDateStr = [dateFormatter stringFromDate:[dateFormatter dateFromString:dateStr]];
    if ([self compareOneDay:[NSDate date] withAnotherDay:[dateFormatter dateFromString:dateStr]]!=0)
    {
        NSDate *timeDate = [dateFormatter dateFromString:dateStr];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:timeDate];
        return timeStr;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [cal components:unitFlags fromDate:[dateFormatter dateFromString:dateStr]];
    
    NSInteger seconds= [[NSDate date] timeIntervalSinceDate:[dateFormatter dateFromString:dateStr]];
    
    NSDate *currDate = [NSDate date];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currDateStr = [dateFormatter stringFromDate:currDate];
  
//    NSString *str = [severDateStr substringToIndex:10];
    
    if ([currDateStr isEqualToString:[severDateStr substringToIndex:10]])
    {
        NSDate *timeDate = [dateFormatter dateFromString:dateStr];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *timeStr = [dateFormatter stringFromDate:timeDate];
        
        return timeStr;
    }else if(seconds/24/3600<2)
    {
        return  @"昨天";
    }else if(seconds<=7*24*3600)
    {
        switch ([comps weekday]-1)
        {
            case 0:
                return @"星期日";
                break;
            case 1:
                return @"星期一";
                break;
            case 2:
                return @"星期二";
                break;
            case 3:
                return @"星期三";
                break;
            case 4:
                return @"星期四";
                break;
            case 5:
                return @"星期五";
                break;
            case 6:
                return @"星期六";
                break;
            default:
                return @"星期日";
                break;
        }
    }else
    {
        NSDate *timeDate = [dateFormatter dateFromString:dateStr];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *timeStr = [dateFormatter stringFromDate:timeDate];
        return timeStr;
    }
}


+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}

#pragma mark - 时间对比
+ (NSString *)formateDate:(NSString *)dateString
{
    
    @try {
        
        // ------实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//这里的格式必须和DateString格式一致
        
        NSDate * nowDate = [NSDate date];
        
        // ------将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        
        
        // ------取当前时间和转换时间两个日期对象的时间间隔
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //        NSLog(@"time----%f",time);
        // ------再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = [[NSString alloc] init];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if (time<=60) {  //1分钟以内的
            
            dateStr = @"刚刚";
            
        }else if(time<=60*60){  //一个小时以内的
            dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
            //            int mins = time/60;
            //            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){  //在两天内的
            
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //在同一天
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                //昨天
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
            }
            //            if ([need_yMd isEqualToString:now_yMd]) {
            //                //在同一天
            //                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            //            }else{
            //                //昨天
            //                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            //            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                //在同一年
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

/* 改变部分字符串颜色1 */
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString
{
    if (!string) {
        return nil;
    }
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:tempString];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:DXDA_DefaultColor range:range];
    
    return mAttStri;
}

/* 改变部分字符串颜色2 */
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString color:(UIColor *)color
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:tempString];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return mAttStri;
}

/* 改变部分字符串颜色3 */
+(NSAttributedString *)changeColorWithString:(NSString *)string firstString:(NSString *)first secondString:(NSString *)second
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range1 = [string rangeOfString:first];
    
    NSRange range2 = [string rangeOfString:second];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:DXDA_DefaultColor range:range1];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:DXDA_DefaultColor range:range2];
    
    return mAttStri;
}

#pragma mark - 判断字符串是否未空
+(NSString *)returnNumberString:(NSString *)string {
    if ([string isEqualToString:@""] || !string || [string isEqualToString:@"null"] || [string isKindOfClass:[NSNull class]]) {
        return @"0";
    }
    return string;
}
//是否输入的是数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//某一天，往后的第几天的日期
+(NSString *)getNumberDays:(NSInteger)number dateString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *aDate= [dateFormatter dateFromString:dateString];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+number)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
    
}
@end
