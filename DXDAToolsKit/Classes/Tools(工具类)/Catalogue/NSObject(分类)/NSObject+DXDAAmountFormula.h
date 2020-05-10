//
//  NSObject+DXDAAmountFormula.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/8.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXDAArticleInfoModel.h"
@class DXDAGoodsInfoModel;

@interface NSObject (DXDAAmountFormula)

/** 
 * 传值取几位小数
 * @param amount 要取得值
 * @param decimals 取小数点后几位
 * @return 取完小数点后的值
 */
+ (NSNumber *)FormulaAmount:(float)amount Decimals:(NSInteger)decimals;


/** 
 * 计算金额 （修改数量／修改单价 使用）
 * @param quantity 数量
 * @param price 单价
 * @retrun 金额 保留2位小数点
 */
+ (NSNumber *)FormulaQuantity:(float)quantity Price:(float)price;

/**
 * 计算金额 （修改含税金额 使用）
 * @param taxamount 含税金额
 * @param taxrate 税率
 * @retrun 金额 保留2位小数点
 */
+ (NSNumber *)FormulataxAmount:(float)taxamount Taxrate:(float)taxrate;

/**
 * 计算金额 （修改含税单价 使用）
 * @param taxprice 含税单价
 * @param taxrate 税率
 * @param quantity 数量
 * @retrun 金额 保留2位小数点
 */
+ (NSNumber *)FormulataxPricr:(float)taxprice Taxrate:(float)taxrate Quantity:(float)quantity;

/**
 * 计算含税金额 （修改数量／修改含税单价 使用）
 * @param quantity 数量
 * @param taxprice 含税单价
 * @retrun 含税金额 保留2位小数点
 */
+ (NSNumber *)FormulaQuantity:(float)quantity taxPricr:(float)taxprice;

/**
 * 计算含税金额 （修改单价 使用）
 * @param quantity 数量
 * @param price 单价 (修改单价 使用 其他为空 nil)
 * @param taxrate 税率
 * @retrun 含税金额 保留2位小数点
 */
+ (NSNumber *)FormulaQuantity:(float)quantity Pricr:(float)price Taxrate:(float)taxrate;


/**
 * 计算含税金额 （修改金额／修改税率 使用）
 * @param amount 总金额 (修改单价时为空)
 * @param taxrate 税率
 * @retrun 含税金额 保留2位小数点
 */
+ (NSNumber *)FormulaAmount:(float)amount Taxrate:(float)taxrate;

/**
 * 计算含税单价 （修改单价／修改税率 使用）
 * @param price 单价
 * @param taxrate 税率
 * @retrun 含税单价 保留2位小数点
 */
+ (NSNumber *)FormulaPricr:(float)price Taxrate:(float)taxrate;

/**
 * 计算含税单价 （修改金额）
 * @param amount 金额／含税金额
 * @param quantity 数量
 * @param taxrate 税率
 * @retrun 含税单价 保留2位小数点
 */
+ (NSNumber *)FormulaAmount:(float)amount Quantity:(float)quantity Taxrate:(float)taxrate;

/**
 * 计算含税单价 （修改含税金额）
 * @param taxAmount 金额／含税金额
 * @param quantity 数量
 * @retrun 含税单价 保留2位小数点
 */
+ (NSNumber *)FormulataxAmount:(float)taxAmount Quantity:(float)quantity;

/**
 * 计算单价 （修改含税单价 使用）
 * @param taxprice 含税单价
 * @param taxrate 税率 
 * @retrun 单价 保留2位小数点
 */
+ (NSNumber *)FormulataxPricr:(float)taxprice Taxrate:(float)taxrate;

/**
 * 计算单价 （修改金额 使用）
 * @param amount 金额／含税金额
 * @param quantity 数量
 * @retrun 单价 保留2位小数点
 */
+ (NSNumber *)FormulaAmount:(float)amount Quantity:(float)quantity;

/**
 * 计算单价 （修改含税金额 使用）
 * @param taxamount 含税金额
 * @param quantity 数量
 * @param taxrate 税率
 * @retrun 单价 保留2位小数点
 */
+ (NSNumber *)FormulataxAmount:(float)taxamount Quantity:(float)quantity Taxrate:(float)taxrate;


/**
 * 动态保留小数点后几位
 * @param digits 小数点后保留几位
 * @param Float 要取的值
 * @returm 保留小数点后的值
 */
+ (NSNumber *)DXDADigits:(NSNumber*)digits Float:(float)Float;

/**
 * 以单价／税率为基准计算
 * @param quantity 数量
 * @param price 单价
 * @param taxrate 税率
 */
+ (void)FormulaQuantity:(float)quantity Price:(float)price Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;

/**
 * 以含税单价为基准计算
 * @param quantity 数量
 * @param taxprice 含税单价
 * @param taxrate 税率
 */
+ (void)FormulaQuantity:(float)quantity taxPrice:(float)taxprice Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;

/**
 * 以数量为基准计算
 * @param quantity 数量
 * @param taxprice 含税单价
 * @param price 单价
 * @param taxrate 税率
 */
+ (void)FormulaQuantity:(float)quantity taxPrice:(float)taxprice Price:(float)price Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;

/**
 * 以金额为基准计算
 * @param quantity 数量
 * @param amount 金额
 * @param taxrate 税率
 */
+ (void)FormulaAmount:(float)amount Quantity:(float)quantity Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;

/**
 * 以含税金额为基准计算
 * @param quantity 数量
 * @param taxAmount 含税金额
 * @param taxrate 税率
 */
+ (void)FormulataxAmount:(float)taxAmount Quantity:(float)quantity Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;

#pragma mark -  计算含税金额 （修改单价 使用） ccz add
+ (NSNumber *)FormulaQuantity:(float)quantity taxPrice:(float)taxPrice;

/**
 * 计算本币金额
 * @param infoModel 单身model
 * @param exchange_rate 汇率
 */
+(void)calculateAmount:(DXDAArticleInfoModel *)infoModel exchange_rate:(NSString *)exchange_rate;


@end
