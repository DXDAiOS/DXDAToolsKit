//
//  NSString+DXDANSDate_Category.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/22.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSString+DXDANSDate_Category.h"

@implementation NSString (DXDANSDate_Category)
//MARK: - 时间对比
+ (NSString *)formateDate:(NSString *)dateString
{
    
    @try {
        // ------实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //这里的格式必须和DateString格式一致
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
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

//MARK: - 日期转成当前时间
+(NSString *)stringWithDateSwichTime:(NSString *)dateStr
{
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags=NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond| NSCalendarUnitWeekday;
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *severDateStr = [dateFormatter stringFromDate:[dateFormatter dateFromString:dateStr]];
    if ([self compareOneDay:[NSDate date] withAnotherDay:[dateFormatter dateFromString:dateStr] formater:@"yyyy"]!=0)
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

//MARK: - 时间对比
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay  formater:(NSString *)formater
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formater];
    
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

//MARK: - 返回当前时间字符串 年月日 时分秒
+(NSString *)returnCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

//MARK: - 返回当前日期字符串 年月日
+(NSString *)returnCurrentDate_YMD {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

//MARK: - 返回当前日期 date 年月日 自定义
+ (NSDate *)returnStringToDate:(NSString *)string formater:(NSString *)formater {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formater;
    return [formatter dateFromString:string ? : @""];
}

//MARK: - date To string 自定义
+ (NSString *)returnDateToString:(NSDate *)date formater:(NSString *)formater {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formater;
    return [formatter stringFromDate:date];
}

//MARK: - 返回当前日期 date 年月日
+ (NSDate *)returnStringToDate:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter dateFromString:string ? : @""];
}

//MARK: - date To string
+ (NSString *)returnDateToString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}
//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

//MARK: - 返回当前日期字符串 年月日 时分秒  低配版
+(NSString *)returnChangeDate_HMS:(NSString *)string {
    
    NSString *date = [string copy];
    
    if (date.length < 16) {
        return date;
    }
    
    if ([date containsString:@"/"]) {
        date = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    //    formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    //    formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //    formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
    //    formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    //    formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    //    formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    
    NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
    formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    
    NSString *changeStr = @"";
    
    if (date.length > 10) {
        NSArray *tempArray = [date componentsSeparatedByString:@"."];
        if (tempArray.count < 2) {
            return date;
        }
        changeStr = tempArray[0];
    }
    
    //    if (date.length == 19) {
    //        NSDate *changeDate = [formatter2 dateFromString:date];
    //        changeStr = [formatter stringFromDate:changeDate];
    //    }
    //    else if (date.length == 23) {
    //        NSDate *changeDate = [formatter4 dateFromString:date];
    //        changeStr = [formatter stringFromDate:changeDate];
    //    }
    
    return changeStr;
}

//MARK: - 返回当前日期字符串 年月日 时分  低配版
+(NSString *)returnChangeDate_HM:(NSString *)string {
    
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (string.length == 0) {
        return @"";
    }
    
    NSString *date = [string copy];
    
    if (date.length < 16) {
        return date;
    }
    
    if ([date containsString:@"/"]) {
        date = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
//    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
//    formatter1.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    formatter1.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter2.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
//    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
//    formatter3.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//    formatter3.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//    formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    
    NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
    formatter4.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter4.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";

    NSString *changeStr = @"";
    
    if (date.length > 10) {
        NSArray *tempArray = [date componentsSeparatedByString:@":"];
        if (tempArray.count < 2) {
            return date;
        }
        changeStr = [NSString stringWithFormat:@"%@:%@",tempArray[0],tempArray[1]];
    }
    
//    if (date.length == 19) {
//        NSDate *changeDate = [formatter2 dateFromString:date];
//        changeStr = [formatter stringFromDate:changeDate];
//    }
//    else if (date.length == 23) {
//        NSDate *changeDate = [formatter4 dateFromString:date];
//        changeStr = [formatter stringFromDate:changeDate];
//    }

    return changeStr;
}

//MARK: - 返回当前日期 年月日 时分
+(NSString *)returnDate:(NSString *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter2=[[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *severDateStr = [dateFormatter2 stringFromDate:[dateFormatter dateFromString:date]];
    return severDateStr ? : @"";
}

//MARK: - 返回当前日期 年月日 时分
+(NSDate *)returnDate_HM:(NSString *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *severDateStr = [dateFormatter stringFromDate:[dateFormatter dateFromString:date]];
    return [dateFormatter dateFromString:date];
}

//MARK: - 根据当前日期 类型 返回 下一个月 或者 下周日期
+(NSString *)returnNextDateWith:(NSString *)currentDate type:(ReturnNextDateType)type count:(NSInteger)count {
    
    // 设置日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 转换 NSDate 类型
    NSDate *myDate = [formatter dateFromString:currentDate];
    
    // 初始化日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:myDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    // 年
    [adcomps setYear:0];
    
    if (type == ReturnNextDateType_month) {
        // 月
        [adcomps setMonth:count];
        
        // 日
        [adcomps setDay:0];
    }
    else if (type == ReturnNextDateType_week) {
        // 月
        [adcomps setMonth:0];
        
        // 日
        [adcomps setDay:7*count];
    }
    else if (type == ReturnNextDateType_year) {
        [adcomps setYear:count];
    }
    
    NSDate *newDate = [calendar dateByAddingComponents:adcomps toDate:myDate options:0];
    
    NSString *newDateString = [formatter stringFromDate:newDate];
    
    return newDateString;
}

//MARK: - 返回 本周、本月、本季、近三个月
+ (NSArray<NSString *> *)returnThisDate:(ReturnThisDateType)type {
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *nowDate = [NSDate date];
    
    NSDateComponents *currentComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:nowDate];

    NSString *fisrtString = @"";
    NSString *lastString = @"";
    //MARK: - 返回 本周日期
    if (type == ReturnThisDateType_week) {
        NSArray *weekArray = [NSString returnWeekDateToDefineDate:[NSString returnCurrentDate_YMD]];
        fisrtString = weekArray[0];
        lastString = weekArray[1];
    }
    //MARK: - 返回 上周日期
    else if (type == ReturnThisDateType_lastWeek) {
        NSString *lastWeekToday = [NSString returnNextDateWith:[NSString returnCurrentDate_YMD] type:ReturnNextDateType_week count:-1];
        NSArray *weekArray = [NSString returnWeekDateToDefineDate:lastWeekToday];
        fisrtString = weekArray[0];
        lastString = weekArray[1];
    }
    //MARK: - 返回 本月日期
    else if (type == ReturnThisDateType_month) {
        NSInteger monthDay = [currentComp month];
        fisrtString = [NSString returnFirstDateToDefineMonth:monthDay defineYMD:[formater stringFromDate:nowDate]];
        lastString = [NSString returnLastDateToDefineMonth:monthDay defineYMD:[formater stringFromDate:nowDate]];
    }
    //MARK: - 返回 上月日期
    else if (type == ReturnThisDateType_lastMonth) {

        NSString *lastMonth = [NSString returnNextDateWith:[NSString returnCurrentDate_YMD] type:ReturnNextDateType_month count:-1];
        
        currentComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                                    fromDate:[formater dateFromString:lastMonth]];
        NSInteger month = [currentComp month];
        
        fisrtString = [NSString returnFirstDateToDefineMonth:month defineYMD:lastMonth];
        lastString = [NSString returnLastDateToDefineMonth:month defineYMD:lastMonth];
    }
    //MARK: - 返回 本季日期
    else if (type == ReturnThisDateType_season) {
        NSInteger monthDay = [currentComp month];
        if (monthDay >= 1 && monthDay <= 3) {
            fisrtString = [NSString returnFirstDateToDefineMonth:1 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:3 defineYMD:[formater stringFromDate:nowDate]];
        }
        else if (monthDay >= 4 && monthDay <= 6) {
            fisrtString = [NSString returnFirstDateToDefineMonth:4 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:6 defineYMD:[formater stringFromDate:nowDate]];
        }
        else if (monthDay >= 7 && monthDay <= 9) {
            fisrtString = [NSString returnFirstDateToDefineMonth:7 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:9 defineYMD:[formater stringFromDate:nowDate]];
        }
        else if (monthDay >= 10 && monthDay <= 12) {
            fisrtString = [NSString returnFirstDateToDefineMonth:10 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:12 defineYMD:[formater stringFromDate:nowDate]];
        }
    }
    //MARK: - 返回 上季日期
    else if (type == ReturnThisDateType_lastSeason) {
        NSInteger monthDay = [currentComp month];
        NSString *lastYear = [NSString returnNextDateWith:[NSString returnCurrentDate_YMD] type:ReturnNextDateType_year count:-1];
        if (monthDay >= 1 && monthDay <= 3) {
            fisrtString = [NSString returnFirstDateToDefineMonth:10 defineYMD:lastYear];
            lastString = [NSString returnLastDateToDefineMonth:12 defineYMD:lastYear];
        }
        else if (monthDay >= 4 && monthDay <= 6) {
            fisrtString = [NSString returnFirstDateToDefineMonth:1 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:3 defineYMD:[formater stringFromDate:nowDate]];
        }
        else if (monthDay >= 7 && monthDay <= 9) {
            fisrtString = [NSString returnFirstDateToDefineMonth:4 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:6 defineYMD:[formater stringFromDate:nowDate]];
        }
        else if (monthDay >= 10 && monthDay <= 12) {
            fisrtString = [NSString returnFirstDateToDefineMonth:7 defineYMD:[formater stringFromDate:nowDate]];
            lastString = [NSString returnLastDateToDefineMonth:9 defineYMD:[formater stringFromDate:nowDate]];
        }
    }
    //MARK: - 返回 本年日期
    else if (type == ReturnThisDateType_year) {
        fisrtString = [NSString returnFirstDateToDefineMonth:1 defineYMD:[formater stringFromDate:nowDate]];
        lastString = [NSString returnLastDateToDefineMonth:12 defineYMD:[formater stringFromDate:nowDate]];
    }
    //MARK: - 返回 上年日期
    else if (type == ReturnThisDateType_lastYear) {
        NSString *lastYear = [NSString returnNextDateWith:[NSString returnCurrentDate_YMD] type:ReturnNextDateType_year count:-1];
        fisrtString = [NSString returnFirstDateToDefineMonth:1 defineYMD:lastYear];
        lastString = [NSString returnLastDateToDefineMonth:12 defineYMD:lastYear];
    }
    //MARK: - 返回 近三个月
    else if (type == ReturnThisDateType_agoMonth) {
        fisrtString = [NSString returnNextDateWith:[NSString returnCurrentDate_YMD] type:ReturnNextDateType_month count:-3];
        lastString = [NSString returnCurrentDate_YMD];
    }
    else {}
    
    return @[fisrtString,lastString];
}

//MARK: - 根据 日期 返回 星期一 星期日 defineYMD 表示年份 yyyy-MM-dd
+ (NSArray<NSString *> *)returnWeekDateToDefineDate:(NSString *)date {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *defineDate = [formater dateFromString:date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:defineDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    NSInteger firstDiff,lastDiff;
    
    if (weekDay == 1)
    {
        firstDiff = 6;
        lastDiff = 0;
    }
    else if (weekDay == 2)
    {
        firstDiff = 0;
        lastDiff = 6;
    }
    else
    {
        firstDiff = weekDay - 2;
        lastDiff = 8 - weekDay;
    }
    
    [comp setDay:day - firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:comp];
    
    [comp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:comp];
    
    NSString *fisrtString = [formater stringFromDate:firstDayOfWeek] ? : @"";
    NSString *lastString = [formater stringFromDate:lastDayOfWeek] ? : @"";
    
    return @[fisrtString, lastString];
}


//MARK: - 根据 月份 返回 第一日
+ (NSString *)returnFirstDateToDefineMonth:(NSInteger)month defineYMD:(NSString *)ymd {
    
    // 设置日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    // 初始化日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [dateFormatter dateFromString:ymd];
    
    // 根据日历获取当前日期组件
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:date];
    
    // 重新设置 月份 日期
    [component setDay:1];
    [component setMonth:month];
    
    // 获取所需 月份 日期
    NSDate *firstDate = [calendar dateFromComponents:component];
    
    // 转换 月份 日期 字符串
    NSString *firstString = [dateFormatter stringFromDate:firstDate];
    
    return firstString;

}

//MARK: - 根据 月份 返回 最后一日
+ (NSString *)returnLastDateToDefineMonth:(NSInteger)month defineYMD:(NSString *)ymd {
    
    // 设置日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // 初始化日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [dateFormatter dateFromString:ymd];
    
    // 根据日历获取当前日期组件
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                              fromDate:date];
    
    // 重新设置 月份 日期
    [component setMonth:month];
    
    // 获取所需 月份 日期
    NSDate *lastDate = [calendar dateFromComponents:component];
    
    // 获取 月份长度
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:lastDate];
    
    // 再次重新设置 月份 日期
    [component setDay:range.length];
    
    // 再次获取所需 月份 日期
    lastDate = [calendar dateFromComponents:component];
    
    // 转换 月份 日期 字符串
    NSString *lastString = [dateFormatter stringFromDate:lastDate];
    
    return lastString;
}

//当前时间到服务器返回时间的天数
+ (NSString *)dayCurrentDateToOneDate:(NSString *)oneDate withFormater:(NSString *)formater
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formater;
    
    //某个时间
    NSArray *seperatorArray = [dataStr(oneDate) componentsSeparatedByString:@"T"];
    NSString *oneDateStr = [self string:seperatorArray.firstObject FromFormatter:@"yyyy-MM-dd HH:mm:ss" toFormatter:@"yyyy-MM-dd"];
    NSDate *tempOneDate = [dateFormatter dateFromString:oneDateStr];
    
    //当前时间
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
    
    NSTimeInterval interval = [tempOneDate timeIntervalSinceDate:currentDate];
    NSString *resultDays = [NSString stringWithFormat:@"%ld", (NSInteger)(interval/(60*60*24))];
    
    return resultDays;
}

// 对比两个时间天数
+ (NSString *)dayCurrentDateToOneDate:(NSString *)oneDate TwoDate:(NSString *)TwoDate  withFormater:(NSString *)formater
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formater;
    
    //某个时间
    NSArray *seperatorArray = [dataStr(oneDate) componentsSeparatedByString:@"T"];
    NSString *oneDateStr = [self string:seperatorArray.firstObject FromFormatter:@"yyyy-MM-dd HH:mm:ss" toFormatter:@"yyyy-MM-dd"];
    NSDate *tempOneDate = [dateFormatter dateFromString:oneDateStr];
    
    //对比时间
    NSArray *seperatorArray1 = [dataStr(TwoDate) componentsSeparatedByString:@"T"];
    NSString *oneDateStr1 = [self string:seperatorArray1.firstObject FromFormatter:@"yyyy-MM-dd HH:mm:ss" toFormatter:@"yyyy-MM-dd"];
    NSDate *tempOneDate1 = [dateFormatter dateFromString:oneDateStr1];
    
    NSTimeInterval interval = [tempOneDate timeIntervalSinceDate:tempOneDate1];
    NSString *resultDays = [NSString stringWithFormat:@"%ld", (NSInteger)(interval/(60*60*24))];
    
    return resultDays;
}

+(NSString *)string:(NSString *)CWtimeStr FromFormatter:(NSString *)CWformatter toFormatter:(NSString*)CWToFormatter
{
    if (CWformatter==nil || [CWformatter isEqualToString:@""]) {
        return @"";
    }
    else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:CWformatter];
        NSDate * tmpDate = [formatter dateFromString:CWtimeStr];
        [formatter setDateFormat:CWToFormatter];
        NSString * retStr = [formatter stringFromDate:tmpDate];
        
        if (retStr) {
            
            return retStr;
            
        }else {
            
            return @"";
        }
        
    }
}

+ (NSString *)getMoneyStringWithMoneyNumber:(double)money
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:money]];
    return formattedNumberString;
}
//传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

/**
 *  得到这个周的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisWeek
{
    DXDAzpDateModel *model = [[DXDAzpDateModel alloc]init];
    NSArray *dateArr = model.getAllWeekDate;
    NSArray *date = dateArr[model.defaultWeek];
    return [NSArray arrayWithObjects:date[1],date[2], nil];
}

/**
 *  得到这个月的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:[NSDate date]];
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *firstDay1 = [dateFormatter stringFromDate:firstDay];
    NSString *lastDay1 = [dateFormatter stringFromDate:lastDay];
    return [NSArray arrayWithObjects:firstDay1,lastDay1, nil];
}
//比较两个时间的大小  //bDate比aDate大 == 1 //bDate比aDate小 == -1
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //相等
        aa=0;
    }else if (result== NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else {
        //bDate比aDate小
        aa=-1;
    }
    return aa;
}
//比较两个时间的大小  //bDate比aDate大 == 1 //bDate比aDate小 == -1
+ (NSInteger)compareDateYMDHMS:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //相等
        aa=0;
    }else if (result== NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else {
        //bDate比aDate小
        aa=-1;
    }
    return aa;
}


//本周

+(DXDASalesShoppingSearchModel *)addWeek
{
    //本周
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:now];
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    NSInteger firstDiff,lastDiff;
    if (weekDay == 1)
    {
        firstDiff = 6;
        lastDiff = 0;
    }
    else if (weekDay == 2)
    {
        firstDiff = 0;
        lastDiff = 6;
    }
    else
    {
        firstDiff = weekDay - 2;
        lastDiff = 8 - weekDay;
    }
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day - firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    DXDASalesShoppingSearchModel *week = [[DXDASalesShoppingSearchModel alloc]init];
    week.trans_date_begin = [formater stringFromDate:firstDayOfWeek];
    //    week.trans_date_end = [formater stringFromDate:lastDayOfWeek];
    //    后端要求结束时间要往后加多一天。
    week.trans_date_end = [NSString GetTomorrowDay:lastDayOfWeek];
    week.title = @"本周";
    week.dateIndex = 2;
    return week;
}
//本月
+(DXDASalesShoppingSearchModel *)addMouth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:1];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:now];
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:range.length];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    DXDASalesShoppingSearchModel *mouth = [[DXDASalesShoppingSearchModel alloc]init];
    mouth.trans_date_begin = [formater stringFromDate:firstDayOfWeek];
    //    mouth.trans_date_end = [formater stringFromDate:lastDayOfWeek];
    //后端要求结束时间要往后加多一天。
    mouth.trans_date_end = [NSString GetTomorrowDay:lastDayOfWeek];
    mouth.title = @"本月";
    mouth.dateIndex = 3;
    return mouth;
    
}
//近三个月
+(DXDASalesShoppingSearchModel *)addThreeMouth
{
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-3];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    DXDASalesShoppingSearchModel *mouth = [[DXDASalesShoppingSearchModel alloc]init];
    mouth.trans_date_begin = beforDate;
    //后端要求结束时间要往后加多一天。
    mouth.trans_date_end = [NSString GetTomorrowDay:[NSDate date]];
    mouth.title = @"近三个月";
    mouth.dateIndex = 4;
    return mouth;
}
//昨天
+(DXDASalesShoppingSearchModel *)addYestoday
{
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:-1];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    DXDASalesShoppingSearchModel *yesterday = [[DXDASalesShoppingSearchModel alloc]init];
    yesterday.trans_date_begin = beforDate;
    //后端要求结束时间要往后加多一天。
    yesterday.trans_date_end = [NSString GetTomorrowDay:newdate];
    yesterday.title = @"昨日";
    yesterday.dateIndex = 5;
    return yesterday;
}
//上一周
+(DXDASalesShoppingSearchModel *)addLastWeek
{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一周的秒数
    NSTimeInterval time = 7 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay
                                         fromDate:lastWeek];
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    NSInteger firstDiff,lastDiff;
    if (weekDay == 1)
    {
        firstDiff = 6;
        lastDiff = 0;
    }
    else if (weekDay == 2)
    {
        firstDiff = 0;
        lastDiff = 6;
    }
    else
    {
        firstDiff = weekDay - 2;
        lastDiff = 8 - weekDay;
    }
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:lastWeek];
    [firstDayComp setDay:day - firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:lastWeek];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    DXDASalesShoppingSearchModel *week = [[DXDASalesShoppingSearchModel alloc]init];
    week.trans_date_begin = [formater stringFromDate:firstDayOfWeek];
    //    week.trans_date_end = [formater stringFromDate:lastDayOfWeek];
    //    后端要求结束时间要往后加多一天。
    week.trans_date_end = [NSString GetTomorrowDay:lastDayOfWeek];
    week.title = @"上周";
    week.dateIndex = 6;
    return week;
}
//上月
+(DXDASalesShoppingSearchModel *)addLastMonth
{
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    
    NSDateComponents *firstDayComp = [calendar1 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];
    [firstDayComp setDay:1];
    NSDate *firstDayOfWeek= [calendar1 dateFromComponents:firstDayComp];
    
    NSRange range = [calendar1 rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newdate];
    NSDateComponents *lastDayComp = [calendar1 components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:newdate];
    [lastDayComp setDay:range.length];
    NSDate *lastDayOfWeek= [calendar1 dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    DXDASalesShoppingSearchModel *mouth = [[DXDASalesShoppingSearchModel alloc]init];
    mouth.trans_date_begin = [formater stringFromDate:firstDayOfWeek];
    //    mouth.trans_date_end = [formater stringFromDate:lastDayOfWeek];
    //后端要求结束时间要往后加多一天。
    mouth.trans_date_end = [NSString GetTomorrowDay:lastDayOfWeek];
    mouth.title = @"上月";
    mouth.dateIndex = 7;
    return mouth;
}
@end
