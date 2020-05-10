//
//  NSObject+DXDAObject_Category.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/22.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DXDAObject_Category)

#pragma mark -  ---------- 数据处理
/**
 * 保留小数点 2位
 */
+(CGFloat)floatType:(CGFloat)value;

#pragma mark -  ---------- 数据判断
/**
 * 判断是否可以跳转
 */
+(BOOL)judgeCurrentControllerCanPush:(NSString *)controllerTitle;

//MARK: - 改变 单头 的 税目信息
+(void)changeHeadTaxInfos:(DXDAAddListModel *)listModel taxModel:(id)model;

//MARK: - 改变 单身 的 税目信息
+(void)changeBodyTaxInfos:(DXDAAddListModel *)listModel;

//MARK: - 数字转中文
+ (NSString *)ChineseWithInteger:(NSInteger)integer;

//加法运算 one+two
+(NSString *)jia_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two;
//减法运算 one-two
+(NSString *)jian_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two;
//乘法运算 one*two
+(NSString *)cheng_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two;
//除法运算 one/two
+(NSString *)chu_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two;

@end
