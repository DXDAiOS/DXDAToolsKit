//
//  DXDATools.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/3/18.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "DXDATools.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "DXDADepartmentModel.h"

@implementation DXDATools
+ (NSString *)DateString{
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区ƒ√
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    return currentDateString;
}
+ (NSString *)DateString:(NSString *)type{
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:type];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    return currentDateString;
}
+ (NSString *)DateStringDate:(NSString *)String
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[String componentsSeparatedByString:@"."][0]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *DateString = [dateFormatter stringFromDate:date];
    if (!DateString) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:[String componentsSeparatedByString:@"."][0]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //NSDate转NSString
        DateString = [dateFormatter stringFromDate:date];
    }
    return DateString?:@"";
}
/*
 * Digits 位数
 * Float  Float值
 */
+ (NSString *)DXDADigits:(NSString *)Digits Float:(float)Float
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:[Digits integerValue]?:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *roundedOunces;
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:roundf(Float)];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *Str = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Float]];
//    NSNumber *Number = [numberFormatter numberFromString:Str];

    return Str;
}

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getcddress:(BOOL)preferIPv4
{
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    NSArray *searchArray = [self isIpv6] ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
#pragma mark - 获取设备当前网络IP地址

+ (BOOL)isIpv6{
    NSArray *searchArray =
    @[ IOS_VPN @"/" IP_ADDR_IPv6,
       IOS_VPN @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block BOOL isIpv6 = NO;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         
         NSLog(@"---%@---%@---",key, addresses[key] );
         
         if ([key rangeOfString:@"ipv6"].length > 0  && ![[NSString stringWithFormat:@"%@",addresses[key]] hasPrefix:@"(null)"] ) {
             
             if ( ![addresses[key] hasPrefix:@"fe80"]) {
                 isIpv6 = YES;
             }
         }
     } ];
    
    return isIpv6;
}

+ (NSMutableArray *)fetchContactWithAddressBook:(ABAddressBookRef)addressBook{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {////有权限访问
        //获取联系人数组
        NSArray *array = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        NSMutableArray *contacts = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            //获取联系人
            ABRecordRef people = CFArrayGetValueAtIndex((__bridge ABRecordRef)array, i);
            //获取联系人详细信息,如:姓名,电话,住址等信息
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonFirstNameProperty);
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue(people, kABPersonLastNameProperty);
            ABMutableMultiValueRef *phoneNumRef = ABRecordCopyValue(people, kABPersonPhoneProperty);
            NSString *phoneNumber =  ((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneNumRef)).lastObject;
            if ([phoneNumber isMobileNumber]) {
                if (lastName||firstName) {
                    [contacts addObject:@{@"name": [lastName?:@"" stringByAppendingString:firstName?:@""], @"phoneNumber": phoneNumber?:@""}];
                }
            }
        }
        return contacts;
    }else{//无权限访问
        NSLog(@"无权限访问通讯录");
        return @[];
    }
}
+ (NSString *)urlRequestOperation{
    NSString *IP;
    NSString *URLTmp1 = @"http://1212.ip138.com/ic.asp";
    NSString *URLTmp = [URLTmp1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData * resData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLTmp]];
    if (resData) {
        //系统自带JSON解析
//        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //您的IP是：[122.222.122.22] 来自：上海市某某区 某某运营商
//        NSString *str3 = [[NSString alloc] initWithData:resData encoding:gbkEncoding];
//        IP = [[str3 componentsSeparatedByString:@"["][1] componentsSeparatedByString:@"]"][0];
        IP = @"";
    }
    return IP;
}

+ (UIImage *)imageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (CGSize)boundingRectWithFont:(UIFont*)font String:(NSString *)text size:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [text boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin
//                      NSStringDrawingUsesFontLeading|
//                      NSStringDrawingUsesDeviceMetrics
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

+ (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;
{
    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    return adjustedSize;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        [[UIResponder returnController] showWith:@"数据发送错误"];
        return nil;
    }
    return dic;
}

+ (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

+ (BOOL)OldEquipment
{
    return YES;
}

+ (NSString *)platformString
{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3 (China Model)";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"i386"]) return @"Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"Simulator";
    return platform;
}

+ (NSString *) platform{
    
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
    
}

//传入后台请求的没有排序的数组，返回排序后的多级列表数据
+(NSMutableArray <DXDADepartmentModel *>*)returnTatalArrayWith:(NSMutableArray <DXDADepartmentModel *>*)allArr
{
    
    if (allArr.count == 0) {
        return [NSMutableArray array];
    }
    
    //筛选出根目录以及子级内容
    NSMutableArray *rootArr = [NSMutableArray array];//根数组
    NSMutableArray *subArr = [NSMutableArray array];//所有的子级数组
    [allArr enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        DXDADepartmentModel *rootModel = obj1;
        if (rootModel.parent_dept_id.length == 0) {
            [rootArr addObject:rootModel];
        }else{
            [subArr addObject:rootModel];
        }
    }];
    
    int i = 0;
    NSMutableArray *subArrItems = [NSMutableArray array];//用来存储各个子级数组
    NSMutableArray *subDicItems = [NSMutableArray array];//把部们id放在一个字典里，方便子级的父级id永远筛选。
    bool isHaveSub = YES;
    while (isHaveSub) { //当没有子级就跳出循环
        //子级目录
        NSMutableArray *twoArr = [NSMutableArray array];//用来下一级的循环
        NSMutableDictionary *twoDict = [NSMutableDictionary dictionary];//根据上一级的的子级
        
        NSMutableArray *arr = [NSMutableArray array];
        if (i == 0) { //第一次进来是根数组
            arr = rootArr;
        }else{
            arr = subArrItems[i-1];
        }
        
        for (DXDADepartmentModel *model in arr) { //父级
            NSMutableArray *twoA = [NSMutableArray array];
            for (DXDADepartmentModel *mod in subArr) { //子级
                if ([model.dept_id isEqualToString:mod.parent_dept_id]) {
                    [twoA addObject:mod];
                    [twoArr addObject:mod];
                    model.isHaveSub = YES;
                }
            }
            [twoDict setValue:twoA forKey:model.dept_id]; //以父级的id存储
        }
        i = i + 1;
        [subArrItems addObject:twoArr];
        [subDicItems addObject:twoDict];
        
        if (twoArr.count == 0) { //表示没有了下级
            isHaveSub = NO;
        }
    };
    
    //重新编码排序
    NSMutableArray *cateARR = [NSMutableArray array];
    
    for (DXDADepartmentModel *model in rootArr) {
        model.parentId = -1;
        model.depth = 0;
        model.expand = YES;
        [cateARR addObject:model];
    }
    
    for (int j = 0; j < i-1 ; j++) {//i 为上面多少个子级的数量
        
        for (int k = 0; k < cateARR.count; k++) { //思路：遍历一遍，插入二级，在遍历，再插入三级，依次类推。
            
            DXDADepartmentModel *model = cateARR[k];
            NSDictionary *twoDict = subDicItems[j];
            
            BOOL rootBool = [[twoDict allKeys] containsObject:model.dept_id];
            
            if (rootBool == YES) {
                NSMutableArray *tempData = [NSMutableArray array];
                NSMutableArray *twoArray = twoDict[model.dept_id];
                for (DXDADepartmentModel *oneModel in twoArray) {
                    oneModel.depth = j+1;
                    oneModel.expand = NO;
                    [tempData addObject:oneModel];
                }
                
                if (tempData.count > 0) {
                    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(k+1, tempData.count)];
                    [cateARR insertObjects:tempData atIndexes:set];
                }
            }
        }
    }

    for (int i = 0; i < cateARR.count; i++) {
        DXDADepartmentModel *model = cateARR[i];
        model.nodeId = i;
    }
    
    //保存一级的nodeid
    //保存二级的nodeid
    NSMutableArray *nodeIDArr = [NSMutableArray array]; //保存各级最后的nodeid
    for (int j = 0; j < i; j++) { //i 为上面多少个子级的数量
        [nodeIDArr addObject:@(0)];
    }
    
    for (int i = 0; i < cateARR.count; i++) {
        DXDADepartmentModel *model = cateARR[i];
        //保存
        nodeIDArr[model.depth] = @(model.nodeId);
        //设置
        model.parentId = -1;
        
        DXDADepartmentModel *upModel = nil;
        if (i>0) {
            upModel = cateARR[i-1];
            if (model.depth == 0) {
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                model.parentId = -1;
                
            }else{
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                NSNumber *number = nodeIDArr[model.depth - 1];
                model.parentId = number.intValue;
            }
        }
    }
    
    return cateARR;
    
}
//传入后台请求的没有排序的数组，返回排序后的多级列表数据 插入了 全部 的选项
+(NSMutableArray <DXDADepartmentModel *>*)returnTatalArrayWithAllTitle:(NSMutableArray <DXDADepartmentModel *>*)allArr
{
    
    if (allArr.count == 0) {
        return [NSMutableArray array];
    }
    
    //筛选出根目录以及子级内容
    NSMutableArray *rootArr = [NSMutableArray array];//根数组
    NSMutableArray *subArr = [NSMutableArray array];//所有的子级数组
    [allArr enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        DXDADepartmentModel *rootModel = obj1;
        if (rootModel.parent_dept_id.length == 0) {
            [rootArr addObject:rootModel];
        }else{
            [subArr addObject:rootModel];
        }
    }];
    
    int i = 0;
    NSMutableArray *subArrItems = [NSMutableArray array];//用来存储各个子级数组
    NSMutableArray *subDicItems = [NSMutableArray array];//把部们id放在一个字典里，方便子级的父级id永远筛选。
    bool isHaveSub = YES;
    while (isHaveSub) { //当没有子级就跳出循环
        //子级目录
        NSMutableArray *twoArr = [NSMutableArray array];//用来下一级的循环
        NSMutableDictionary *twoDict = [NSMutableDictionary dictionary];//根据上一级的的子级
        
        NSMutableArray *arr = [NSMutableArray array];
        if (i == 0) { //第一次进来是根数组
            arr = rootArr;
        }else{
            arr = subArrItems[i-1];
        }
        
        for (DXDADepartmentModel *model in arr) { //父级
            NSMutableArray *twoA = [NSMutableArray array];
            for (DXDADepartmentModel *mod in subArr) { //子级
                if ([model.dept_id isEqualToString:mod.parent_dept_id]) {
                    [twoA addObject:mod];
                    [twoArr addObject:mod];
                    model.isHaveSub = YES;
                }
            }
            [twoDict setValue:twoA forKey:model.dept_id]; //以父级的id存储
        }
        i = i + 1;
        [subArrItems addObject:twoArr];
        [subDicItems addObject:twoDict];
        
        if (twoArr.count == 0) { //表示没有了下级
            isHaveSub = NO;
        }
    };
    
    //重新编码排序
    NSMutableArray *cateARR = [NSMutableArray array];
    //全部
    DXDADepartmentModel *all = [[DXDADepartmentModel alloc]init];
    all.desc = @"全部";
    all.parentId = -1;
    all.depth = 0;
    all.expand = YES;
    all.dept_id = @"getNull";
    all.isChoose = YES;
    [cateARR insertObject:all atIndex:0];
    
    for (DXDADepartmentModel *model in rootArr) {
        model.parentId = -1;
        model.depth = 0;
        model.expand = YES;
        [cateARR addObject:model];
    }
    
    for (int j = 0; j < i-1 ; j++) {//i 为上面多少个子级的数量
        
        for (int k = 0; k < cateARR.count; k++) { //思路：遍历一遍，插入二级，在遍历，再插入三级，依次类推。
            
            DXDADepartmentModel *model = cateARR[k];
            NSDictionary *twoDict = subDicItems[j];
            
            BOOL rootBool = [[twoDict allKeys] containsObject:model.dept_id];
            
            if (rootBool == YES) {
                NSMutableArray *tempData = [NSMutableArray array];
                NSMutableArray *twoArray = twoDict[model.dept_id];
                for (DXDADepartmentModel *oneModel in twoArray) {
                    oneModel.depth = j+1;
                    oneModel.expand = NO;
                    [tempData addObject:oneModel];
                }
                
                if (tempData.count > 0) {
                    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(k+1, tempData.count)];
                    [cateARR insertObjects:tempData atIndexes:set];
                }
            }
        }
    }
    
    for (int i = 0; i < cateARR.count; i++) {
        DXDADepartmentModel *model = cateARR[i];
        model.nodeId = i;
    }
    
    //保存一级的nodeid
    //保存二级的nodeid
    NSMutableArray *nodeIDArr = [NSMutableArray array]; //保存各级最后的nodeid
    for (int j = 0; j < i; j++) { //i 为上面多少个子级的数量
        [nodeIDArr addObject:@(0)];
    }
    
    for (int i = 0; i < cateARR.count; i++) {
        DXDADepartmentModel *model = cateARR[i];
        DXDADepartmentModel *upModel = nil;
        //保存
        nodeIDArr[model.depth] = @(model.nodeId);
        //设置
        model.parentId = -1;
        
        if (i>0) {
            upModel = cateARR[i-1];
            if (model.depth == 0) {
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                model.parentId = -1;
                
            }else{
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                NSNumber *number = nodeIDArr[model.depth - 1];
                model.parentId = number.intValue;
            }
        }
    }
    
    return cateARR;
    
}

//传入后台请求的没有排序的数组，返回排序后的多级列表数据 插入了 全部 的选项 （只获取三级的列表）
+(NSMutableArray <DXDADepartmentModel *>*)returnTatalArrayWithThreeTitle:(NSMutableArray <DXDADepartmentModel *>*)allArr
{
    
    if (allArr.count == 0) {
        return [NSMutableArray array];
    }
    
    //筛选出根目录以及子级内容
    NSMutableArray *rootArr = [NSMutableArray array];//根数组
    NSMutableArray *subArr = [NSMutableArray array];//所有的子级数组
    [allArr enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        DXDADepartmentModel *rootModel = obj1;
        if (rootModel.parent_dept_id.length == 0) {
            [rootArr addObject:rootModel];
        }else{
            [subArr addObject:rootModel];
        }
    }];
    
    int i = 0;
    NSMutableArray *subArrItems = [NSMutableArray array];//用来存储各个子级数组
    NSMutableArray *subDicItems = [NSMutableArray array];//把部们id放在一个字典里，方便子级的父级id永远筛选。
    bool isHaveSub = YES;
    while (isHaveSub) { //当没有子级就跳出循环
        //子级目录
        NSMutableArray *twoArr = [NSMutableArray array];//用来下一级的循环
        NSMutableDictionary *twoDict = [NSMutableDictionary dictionary];//根据上一级的的子级
        
        NSMutableArray *arr = [NSMutableArray array];
        if (i == 0) { //第一次进来是根数组
            arr = rootArr;
        }else{
            arr = subArrItems[i-1];
        }
        
        for (DXDADepartmentModel *model in arr) { //父级
            NSMutableArray *twoA = [NSMutableArray array];
            for (DXDADepartmentModel *mod in subArr) { //子级
                if ([model.dept_id isEqualToString:mod.parent_dept_id]) {
                    [twoA addObject:mod];
                    [twoArr addObject:mod];
                    model.isHaveSub = YES;
                }
            }
            [twoDict setValue:twoA forKey:model.dept_id]; //以父级的id存储
        }
        i = i + 1;
        [subArrItems addObject:twoArr];
        [subDicItems addObject:twoDict];
        
        if (twoArr.count == 0) { //表示没有了下级
            isHaveSub = NO;
        }
        if (i == 3) {
            isHaveSub = NO;
        }
    };
    
    //重新编码排序
    NSMutableArray *cateARR = [NSMutableArray array];
    //全部
    DXDADepartmentModel *all = [[DXDADepartmentModel alloc]init];
    all.desc = @"全部";
    all.parentId = -1;
    all.depth = 0;
    all.expand = YES;
//    all.dept_id = @"getNull";
    all.dept_id = @"";
    all.isChoose = YES;
    [cateARR insertObject:all atIndex:0];
    
    for (DXDADepartmentModel *model in rootArr) {
        model.parentId = -1;
        model.depth = 0;
        model.expand = YES;
        [cateARR addObject:model];
    }
    
    for (int j = 0; j < i-1 ; j++) {//i 为上面多少个子级的数量
        
        for (int k = 0; k < cateARR.count; k++) { //思路：遍历一遍，插入二级，在遍历，再插入三级，依次类推。
            
            DXDADepartmentModel *model = cateARR[k];
            NSDictionary *twoDict = subDicItems[j];
            
            BOOL rootBool = [[twoDict allKeys] containsObject:model.dept_id];
            
            if (rootBool == YES) {
                NSMutableArray *tempData = [NSMutableArray array];
                NSMutableArray *twoArray = twoDict[model.dept_id];
                for (DXDADepartmentModel *oneModel in twoArray) {
                    oneModel.depth = j+1;
                    oneModel.expand = NO;
                    [tempData addObject:oneModel];
                }
                
                if (tempData.count > 0) {
                    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(k+1, tempData.count)];
                    [cateARR insertObjects:tempData atIndexes:set];
                }
            }
        }
    }
    
    for (int i = 0; i < cateARR.count; i++) {
        DXDADepartmentModel *model = cateARR[i];
        model.nodeId = i;
    }
    
    //保存一级的nodeid
    //保存二级的nodeid
    NSMutableArray *nodeIDArr = [NSMutableArray array]; //保存各级最后的nodeid
    for (int j = 0; j < i; j++) { //i 为上面多少个子级的数量
        [nodeIDArr addObject:@(0)];
    }
    
    for (int i = 0; i < cateARR.count; i++) {
        DXDADepartmentModel *model = cateARR[i];
        DXDADepartmentModel *upModel = nil;
        //保存
        nodeIDArr[model.depth] = @(model.nodeId);
        //设置
        model.parentId = -1;
        if (i>0) {
            upModel = cateARR[i-1];
            if (model.depth == 0) {
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                model.parentId = -1;
                
            }else{
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                NSNumber *number = nodeIDArr[model.depth - 1];
                model.parentId = number.intValue;
            }
        }
    }
    
    return cateARR;
    
}


+(NSMutableArray <DXDADepartmentModel *>*)returnMoreThreeArrayWithAll:(NSMutableArray <DXDADepartmentModel *>*)allArr
{
    NSMutableArray *arr = [NSMutableArray array];
    int j = 0;
    NSInteger k = 0;
    for (int i = 0; i < allArr.count; i++) {
        DXDADepartmentModel *model = allArr[i];
        if (model.depth > 2) {
            if (model.depth == 3) model.expand = YES;
            model.depth  = model.depth - 3;
            model.nodeId = j;
            [arr addObject:model];
            j = j+1;
            if (model.depth>k) {//获取最多有多少层的子级
                k = model.depth;
            }
        }
        
    }
    
    //保存一级的nodeid
    //保存二级的nodeid
    NSMutableArray *nodeIDArr = [NSMutableArray array]; //保存各级最后的nodeid
    for (int j = 0; j <= k; j++) { //i 为上面多少个子级的数量
        [nodeIDArr addObject:@(0)];
    }
    
    for (int i = 0; i < arr.count; i++) {
        DXDADepartmentModel *model = arr[i];
        DXDADepartmentModel *upModel = nil;
        //保存
        nodeIDArr[model.depth] = @(model.nodeId);
        //设置
        model.parentId = -1;
        if (i>0) {
            upModel = arr[i-1];
            if (model.depth == 0) {
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                model.parentId = -1;
                
            }else{
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                NSNumber *number = nodeIDArr[model.depth - 1];
                model.parentId = number.intValue;
            }
        }
    }
    return arr;
}

+(NSMutableArray *)MoreThreeArrayWithPart_id:(NSString *)Part_id items:(NSMutableArray *)items
{
    NSMutableArray *arr = [NSMutableArray array];
    
    BOOL isSelect = NO;
    NSInteger k = 0;
    for (int i = 0; i < items.count; i++) {
        DXDADepartmentModel *model = items[i];
        if ([model.parent_dept_id isEqualToString:Part_id] && (model.parentId == -1)) {
            isSelect = YES;
        }
        if (![model.parent_dept_id isEqualToString:Part_id] && (model.parentId == -1)) {
            isSelect = NO;
        }
        if (isSelect) {
            [arr addObject:model];
            if (model.depth>k) {//获取最多有多少层的子级
                k = model.depth;
            }
        }
    }
    
    for (int i = 0; i < arr.count; i++) {
        DXDADepartmentModel *model = arr[i];
        model.nodeId = i;
    }
    //保存一级的nodeid
    //保存二级的nodeid
    NSMutableArray *nodeIDArr = [NSMutableArray array]; //保存各级最后的nodeid
    for (int j = 0; j <= k; j++) { //i 为上面多少个子级的数量
        [nodeIDArr addObject:@(0)];
    }
    
    for (int i = 0; i < arr.count; i++) {
        DXDADepartmentModel *model = arr[i];
        DXDADepartmentModel *upModel = nil;
        //保存
        nodeIDArr[model.depth] = @(model.nodeId);
        //设置
        model.parentId = -1;
        if (i>0) {
            upModel = arr[i-1];
            if (model.depth == 0) {
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                model.parentId = -1;
                
            }else{
                //保存
                nodeIDArr[model.depth] = @(model.nodeId);
                //设置
                NSNumber *number = nodeIDArr[model.depth - 1];
                model.parentId = number.intValue;
            }
        }
    }
    
    return arr;
}
//以下是数据处理
+(NSMutableArray *)dealWithArr:(NSArray*)arr type:(DefaultCategoryType)type
{
    NSMutableArray *items =[NSMutableArray array];
    
    if(type == DefaultCategoryType_materialType){
        for (DXDADefaultCategoryModel *model in arr) {
            model.dept_id = model.product_code;
            [items addObject:model];
        }
    }
    else if (type == DefaultCategoryType_vendorType) {//供应商类别
        for (DXDADefaultCategoryModel *model in arr) {
            model.dept_id = model.vendor_code;
            [items addObject:model];
        }
    }
    else if (type == DefaultCategoryType_customerType){//客户类别
        for (DXDADefaultCategoryModel *model in arr){
            model.dept_id = model.customer_code;
            [items addObject:model];
        }
    }
    else if (type == DefaultCategoryType_wareHouseType){//物料仓库
        for (DXDADefaultCategoryModel *model in arr) {
            model.dept_id = model.location_id;
            [items addObject:model];
        }
    }
    else if (type == DefaultCategoryType_expenseType){//费用项目
        for (DXDADefaultCategoryModel *model in arr) {
            model.dept_id = model.item_id;
            [items addObject:model];
        }
    }
    else if (type == DefaulaCategoryType_progressType){
        for (DXDADefaultCategoryModel *model in arr) {
            model.dept_id = model.status_id;
            [items addObject:model];
        }
    }
    else{
        
    }
    return items;
}

+(NSString *)APPDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *disN = [NSString stringWithFormat:@"%@-Swift.h",app_Name];
    
    return disN;
}


@end
