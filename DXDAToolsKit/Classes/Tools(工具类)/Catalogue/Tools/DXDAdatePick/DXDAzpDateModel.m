//
//  DXDAzpDateModel.m
//  NewApp3.0
//
//  Created by DXDA on 2018/7/5.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import "DXDAzpDateModel.h"

@implementation DXDAzpDateModel

- (NSArray *)getAllWeekDate
{
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [calendar components: NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear fromDate:nowDate];
    
    // 获取今天是周几 (周一是2，周日是1)
    
    NSInteger weekDay = [comp weekday];
    
    //这周是今年的第几周(注意：第一周编号为1不为0)
    
    NSInteger weekOfYear = [comp weekOfYear];
    
    self.defaultWeek = weekOfYear;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSDate *date = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    
    //这周的开始和结束时间 （注意：+1 -1 避开临界值）
    
    NSDate *startdate = [date dateByAddingTimeInterval:24*3600*(2 - weekDay)+1];
    
    NSDate *enddate = [date dateByAddingTimeInterval:24*3600*(9 - weekDay)-1];
    
    NSMutableArray *dateArray = [[[NSMutableArray alloc] init] mutableCopy];
    
    //获取当前年份, 月份, 号数
    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    //一年52周  获取一年的所有周一和周日的日期(注意：第一周编号为1不为0)
    //这里54周 获取了去年最后一周和明年第一周
    for (int i = 0; i <= 53; i++) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *startdate1 = [formatter stringFromDate:[startdate dateByAddingTimeInterval:24*3600*7*(i-weekOfYear)]];
        NSString *enddate1 = [formatter stringFromDate:[enddate dateByAddingTimeInterval:24*3600*7*(i-weekOfYear)]];
        
        NSString *dateStr = @"";
        if (i==0) {
            dateStr = [NSString stringWithFormat:@"%ld年 第52周 %@ - %@",(long)components.year-1,startdate1,enddate1];
        }
        else if (i == 53)
        {
            dateStr = [NSString stringWithFormat:@"%ld年 第1周 %@ - %@",(long)components.year+1,startdate1,enddate1];
        }
        else
        {
            dateStr = [NSString stringWithFormat:@"第%d周 %@ - %@",i,startdate1,enddate1];
        }
        
        [dateArray addObject:@[dateStr,startdate1,enddate1]];
        
    }
    return dateArray;
}


- (NSArray *)getAllMonthDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取当前年份, 月份, 号数
    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    self.defaultMonth = components.month;
    //一年12周
    //这里14周 获取了去年最后一月和明年第一月
    NSMutableArray *monthDateArr = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
    for (int i = 0; i<14; i++) {

        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        NSInteger yearI = i==0 ? -1 : i==13 ? 1 : 0;
        NSInteger monthI = i==0 ? 12 : i==13 ? 1 : i;
        NSLog(@"%@",[NSString stringWithFormat:@"%ld-%ld-01 01:05:07",(long)components.year+yearI,(long)monthI]);
        NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-01 01:05:07",(long)components.year+yearI,(long)monthI];
        NSDate *date = [formatter dateFromString:dateStr];
        NSLog(@"%@",date);
        [monthDateArr addObject:date];
    }
    
    NSMutableArray *dateArray = [[[NSMutableArray alloc] init] mutableCopy];
    
    for (int i = 0 ; i < monthDateArr.count; i++) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = monthDateArr[i];
        //获取月的总天数
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        NSUInteger numberOfDaysInMonth = range.length;
        NSString *startdate = [formatter stringFromDate:date];
        NSString *enddate = [formatter stringFromDate:[date dateByAddingTimeInterval:24*3600*(numberOfDaysInMonth-1)]];
        
        NSString *dateStr = @"";
        if (i==0) {
            dateStr = [NSString stringWithFormat:@"%ld年 第12月 %@ - %@",(long)components.year-1,startdate,enddate];
        }
        else if (i == 13)
        {
            dateStr = [NSString stringWithFormat:@"%ld年 第1月 %@ - %@",(long)components.year+1,startdate,enddate];
        }
        else
        {
            dateStr = [NSString stringWithFormat:@"第%d月 %@ - %@",i,startdate,enddate];
        }
        
        [dateArray addObject:@[dateStr,startdate,enddate]];
    }

    return dateArray;
}

@end
