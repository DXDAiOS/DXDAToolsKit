//
//  NSString+DXDANSDate_Category.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/22.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXDASalesShoppingSearchModel.h"

/**
 ReturnThisDateType 返回当前日期

 - ReturnThisDateType_week: 返回本周
 - ReturnThisDateType_lastWeek: 返回上周
 - ReturnThisDateType_month: 返回本月
 - ReturnThisDateType_lastMonth: 返回上月
 - ReturnThisDateType_season: 返回本季
 - ReturnThisDateType_lastSeason: 返回上季
 - ReturnThisDateType_year: 返回本年
 - ReturnThisDateType_lastYear: 返回上年
 - ReturnThisDateType_agoMonth: 近几个月
 */
typedef NS_ENUM(NSInteger, ReturnThisDateType) {
    ReturnThisDateType_week,
    ReturnThisDateType_lastWeek,
    ReturnThisDateType_month,
    ReturnThisDateType_lastMonth,
    ReturnThisDateType_season,
    ReturnThisDateType_lastSeason,
    ReturnThisDateType_year,
    ReturnThisDateType_lastYear,
    ReturnThisDateType_agoMonth,
};


/**
 ReturnNextDateType 返回下一个周期类型

 - ReturnNextDateType_month: 按月返回
 - ReturnNextDateType_week: 按周返回
 - ReturnNextDateType_season: 按季度返回
 - ReturnNextDateType_year: 按年返回
 */
typedef NS_ENUM(NSInteger, ReturnNextDateType) {
    ReturnNextDateType_month,
    ReturnNextDateType_week,
    ReturnNextDateType_season,
    ReturnNextDateType_year,
};


@interface NSString (DXDANSDate_Category)

/**
 * 时间对比
 * @param dateString 要对比的时间字符串
 * @return 返回时间
 */
+ (NSString *)formateDate:(NSString *)dateString;


/**
 * 日期转成当前时间
 * @param dateStr 要转的时间字符串
 * @return 返回时间
 */
+(NSString *)stringWithDateSwichTime:(NSString *)dateStr;

/**
 *  返回当前时间字符串
 */
+(NSString *)returnCurrentDate;

/**
 *  返回当前日期字符串
 */
+(NSString *)returnCurrentDate_YMD;

//MARK: - 时间对比 1 oneDay比 anotherDay时间晚  -1 oneDay比 anotherDay时间早 0 时间相等
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay formater:(NSString *)formater;
//MARK: - 返回当前日期 date 年月日 自定义
+ (NSDate *)returnStringToDate:(NSString *)string formater:(NSString *)formater;

//MARK: - date To string 自定义
+ (NSString *)returnDateToString:(NSDate *)date formater:(NSString *)formater;

//MARK: - 返回当前日期 date 年月日
+ (NSDate *)returnStringToDate:(NSString *)string;

//MARK: - date To string
+ (NSString *)returnDateToString:(NSDate *)date;
//获取时间戳
+(NSString *)getNowTimeTimestamp3;
//MARK: - 返回当前日期字符串 年月日 时分
+(NSString *)returnChangeDate_HM:(NSString *)date;

//MARK: - 返回当前日期字符串 年月日
+(NSString *)returnDate:(NSString *)date;

//MARK: - 返回当前日期 年月日 时分
+(NSDate *)returnDate_HM:(NSString *)date;

//MARK: - 返回当前日期字符串 年月日 时分秒  低配版
+(NSString *)returnChangeDate_HMS:(NSString *)string;

//MARK: - 根据当前日期 类型 数量 返回 以月为周期返回 或者 以周返回
+(NSMutableArray *)returnNextDatesWith:(NSString *)currentDate type:(ReturnNextDateType)type count:(NSInteger)count;

//MARK: - 根据当前日期 类型 返回 下一个月 或者 下周日期
+(NSString *)returnNextDateWith:(NSString *)currentDate type:(ReturnNextDateType)type count:(NSInteger)count;

//MARK: - 返回 本周、本月、本季、近三个月
+ (NSArray<NSString *> *)returnThisDate:(ReturnThisDateType)type;

//MARK: - 根据 日期 返回 星期一 星期日 defineYMD 表示年份 yyyy-MM-dd
+ (NSArray<NSString *> *)returnWeekDateToDefineDate:(NSString *)date;

//MARK: - 根据 月份 返回 第一日
+ (NSString *)returnFirstDateToDefineMonth:(NSInteger)month defineYMD:(NSString *)ymd;

//MARK: - 根据 月份 返回 最后一日
+ (NSString *)returnLastDateToDefineMonth:(NSInteger)month defineYMD:(NSString *)ymd;

//MARK: -当前时间到服务器返回时间的天数
+ (NSString *)dayCurrentDateToOneDate:(NSString *)oneDate withFormater:(NSString *)formater;
//MARK: -对比两个时间天数
+ (NSString *)dayCurrentDateToOneDate:(NSString *)oneDate TwoDate:(NSString *)TwoDate withFormater:(NSString *)formater;
//MARK: -数字转成货币格式字符串
+ (NSString *)getMoneyStringWithMoneyNumber:(double)money;
//MARK: 传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSDate *)aDate;
/**
 *  得到这个周的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisWeek;
/**
 *  得到这个月的第一天和最后一天
 */
+(NSArray *)getFirstAndLastDayOfThisMonth;
//比较两个时间的大小  //bDate比aDate大 == 1 //bDate比aDate小 == -1
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
+ (NSInteger)compareDateYMDHMS:(NSString*)aDate withDate:(NSString*)bDate;

+(DXDASalesShoppingSearchModel *)addWeek;
//本月
+(DXDASalesShoppingSearchModel *)addMouth;
//近三个月
+(DXDASalesShoppingSearchModel *)addThreeMouth;
//昨天
+(DXDASalesShoppingSearchModel *)addYestoday;
//上一周
+(DXDASalesShoppingSearchModel *)addLastWeek;
//上月
+(DXDASalesShoppingSearchModel *)addLastMonth;

@end
