//
//  DXDATools.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/3/18.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@class DXDADepartmentModel;

@interface DXDATools : NSObject

@property (nonatomic, strong)NSDictionary *ExecuteRouteDic;

+ (NSString *)DateString;

+ (NSString *)DateString:(NSString *)typ;

+ (NSString *)DateStringDate:(NSString *)String;

+ (NSString *)DXDADigits:(NSString *)Digits Float:(float)Float;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;
//首次获取通讯录
//- (void)fetchAddressBookBeforeIOS9;
//获取通讯录
+ (NSMutableArray *)fetchContactWithAddressBook:(ABAddressBookRef)addressBook;

+ (NSString *)urlRequestOperation;

+ (UIImage *)imageWithColor:(UIColor*)color;

+ (CGSize)boundingRectWithFont:(UIFont*)font String:(NSString *)text size:(CGSize)size;
///json 转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
///json 转数组
+ (NSArray *)stringToJSON:(NSString *)jsonStr;

// 设备
+ (NSString *)platformString;
+ (BOOL)OldEquipment;

//传入后台请求的没有排序的数组，返回排序后的多级列表数据
+(NSMutableArray <DXDADepartmentModel *>*)returnTatalArrayWith:(NSMutableArray <DXDADepartmentModel *>*)allArr;

//传入后台请求的没有排序的数组，返回排序后的多级列表数据 插入了 全部 的选项
+(NSMutableArray <DXDADepartmentModel *>*)returnTatalArrayWithAllTitle:(NSMutableArray <DXDADepartmentModel *>*)allArr;
+(NSMutableArray <DXDADepartmentModel *>*)returnMoreThreeArrayWithAll:(NSMutableArray <DXDADepartmentModel *>*)allArr;
//传入后台请求的没有排序的数组，返回排序后的多级列表数据 插入了 全部 的选项 （只获取三级的列表）
+(NSMutableArray <DXDADepartmentModel *>*)returnTatalArrayWithThreeTitle:(NSMutableArray <DXDADepartmentModel *>*)allArr;
+(NSMutableArray *)MoreThreeArrayWithPart_id:(NSString *)Part_id items:(NSMutableArray *)items;
//以下是数据处理
+(NSMutableArray *)dealWithArr:(NSArray*)arr type:(DefaultCategoryType)type;

@end
