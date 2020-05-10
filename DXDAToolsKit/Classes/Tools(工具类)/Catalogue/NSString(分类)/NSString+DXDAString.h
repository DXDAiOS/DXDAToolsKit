//
//  NSString+DXDAString.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/26.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DXDAString)

// 附件
+ (NSString *)accessoryType:(NSString *)orderType;
//MARK: 图文档消息转换 采购 -》 销售
+ (NSString *)noticeAccessoryType:(NSString *)orderType;

//
+ (NSString *)baseURL:(NSString *)url action:(NSString *)action;
//获取联网方式
+ (NSString *)networkType;
//获取运营商信息
+(NSString *)getCarrierName;
@end
