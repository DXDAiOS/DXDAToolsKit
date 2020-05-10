//
//  NSObject+DXDAAmountFormula.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/8.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSObject+DXDAAmountFormula.h"
#import <math.h>

#define PriceDecimals [self returnPriceDecimals]
#define AmountDecimals [self returnAmountDecimals]



@implementation NSObject (DXDAAmountFormula)
-(NSInteger)returnPriceDecimals
{
    UserInfoModel *userInfo = [UserInfoManager sharedUserInfoManager].readUserdata;
    return userInfo.price_digit.integerValue;
    
}
-(NSInteger)returnAmountDecimals
{
    UserInfoModel *userInfo = [UserInfoManager sharedUserInfoManager].readUserdata;
    return userInfo.amount_digit.integerValue;
}
+ (NSNumber *)FormulaAmount:(float)amount Decimals:(NSInteger)decimals
{
    /*
     double a = 120.456;
     double b = 130.455;
     double c = 140.454;
     double d = 120.455;
     double e = 4.015;
     double f = 130.675;
     
     NSLog(@"%.2f---%.2f--%.2f--%.2f",a,b,c,d);
     
     double a1 =(int)(float)((a * 100) + 0.5) / 100.0;
     double b1 =(int)(float)((b * 100) + 0.5) / 100.0;
     double c1 =(int)(float)((c * 100) + 0.5) / 100.0;
     double d1 =(int)(float)((d * 100) + 0.5) / 100.0;
     double e1 =(int)(float)((e * 100) + 0.5) / 100.0;
     double f1 =(int)(float)((f * 100) + 0.5) / 100.0;
     
     NSLog(@"%.2f--%.2f--%.2f--%.2f--%.2f--%.2f",a1,b1,c1,d1,e1,f1);
     */
    float X = powf(10,(float)decimals);
    float N = (float)((int)(float)(amount*X + 0.5) / 100.0);
    return [self DXDADigits:@(decimals) Float:N];
}

#pragma mark -  计算金额 （修改数量／修改单价 使用）
+ (NSNumber *)FormulaQuantity:(float)quantity Price:(float)price
{
    
    float amount = quantity * price;
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  计算金额 （修改含税金额 使用)
+ (NSNumber *)FormulataxAmount:(float)taxamount Taxrate:(float)taxrate
{
    float amount1 = taxamount / (1+taxrate);
    return [self FormulaAmount:amount1 Decimals:2];
}

#pragma mark -  计算金额 （修改含税单价 使用）
+ (NSNumber *)FormulataxPricr:(float)taxprice Taxrate:(float)taxrate Quantity:(float)quantity;
{
    float amount1 = taxprice / (1+taxrate) * quantity;
    return [self FormulaAmount:amount1 Decimals:2];
}

#pragma mark -  计算含税金额 （修改数量／修改含税单价 使用） 
+ (NSNumber *)FormulaQuantity:(float)quantity taxPricr:(float)taxprice
{
    float amount = quantity * float_2(taxprice);
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  计算含税金额 （修改单价 使用）
+ (NSNumber *)FormulaQuantity:(float)quantity Pricr:(float)price Taxrate:(float)taxrate
{
    float amount = quantity * price * (1+taxrate);
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  计算含税金额 （修改单价 使用） ccz add
+ (NSNumber *)FormulaQuantity:(float)quantity taxPrice:(float)taxPrice
{
    float amount = quantity * taxPrice;
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  计算含税金额 （修改金额／修改税率 使用）
+ (NSNumber *)FormulaAmount:(float)amount Taxrate:(float)taxrate
{
    float amount1 = amount * (1+taxrate);
    return [self FormulaAmount:amount1 Decimals:2];
}

#pragma mark -  计算含税单价 （修改单价／修改税率 使用）
+ (NSNumber *)FormulaPricr:(float)price Taxrate:(float)taxrate
{
    float amount = float_2(price) * (1+taxrate);
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  计算含税单价 （修改金额使用）
+ (NSNumber *)FormulaAmount:(float)amount Quantity:(float)quantity Taxrate:(float)taxrate
{
    if (quantity==0) {
        return @(0.00);
    }
    float amount1;
    amount1 = [[self FormulaAmount:amount/quantity Decimals:2] floatValue]*(1+taxrate);

    return [self FormulaAmount:amount1 Decimals:2];
}

#pragma mark -  计算含税单价 （修改含税金额使用）
+ (NSNumber *)FormulataxAmount:(float)taxAmount Quantity:(float)quantity
{
    float amount1;
    amount1 = [[self FormulaAmount:taxAmount/quantity Decimals:2] floatValue];
    return [self FormulaAmount:amount1 Decimals:2];
}

#pragma mark -  计算单价 （修改含税单价 使用）
+ (NSNumber *)FormulataxPricr:(float)taxprice Taxrate:(float)taxrate
{
    float amount = taxprice / (1+taxrate);
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  计算单价 （修改金额 使用）
+ (NSNumber *)FormulaAmount:(float)amount Quantity:(float)quantity;
{
    float amount1 = amount/quantity;
    return [self FormulaAmount:amount1 Decimals:2];
}

#pragma mark -  计算单价 （修改含税金额 使用）
+ (NSNumber *)FormulataxAmount:(float)taxamount Quantity:(float)quantity Taxrate:(float)taxrate;
{
    float amount = [[self FormulaAmount:taxamount/quantity Decimals:2] floatValue]/(1+taxrate);
    return [self FormulaAmount:amount Decimals:2];
}

#pragma mark -  以单价／税率为基准计算
+ (void)FormulaQuantity:(float)quantity Price:(float)prict Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;
{

    //数量
    NSDecimalNumber *quantity1 = [NSDecimalNumber decimalNumberWithString:[@(quantity) stringValue]];
    //单价
    NSDecimalNumber *prict1 = [NSDecimalNumber decimalNumberWithString:[@(prict) stringValue]];
    //税率
    NSDecimalNumber *taxrate1 = [NSDecimalNumber decimalNumberWithString:[@(1+taxrate) stringValue]];
    
    
    DXDAArticleInfoModel *InfoModel = [DXDAArticleInfoModel new];
//    InfoModel.amount = [@(quantity * prict) stringValue];
    
//    InfoModel.quantity = [@(quantity) stringValue];
//    InfoModel.unit_price = [@(prict) stringValue];
//    InfoModel.tax_rate = [@(taxrate) stringValue];
    
//    InfoModel.tax_price = [@(prict * (1+taxrate)) stringValue];
//    InfoModel.goods_amt = [@(quantity * InfoModel.tax_price.doubleValue) stringValue];
    
//    CGFloat tax_price1 = InfoModel.tax_price.doubleValue;
//    InfoModel.all_amt = [@(quantity * tax_price1) stringValue];
    

    // 乘积
    NSDecimalNumber *amount = [quantity1 decimalNumberByMultiplyingBy:prict1];
    NSLog(@"%@",amount.stringValue);
    InfoModel.amount = amount.stringValue;
    InfoModel.quantity = [@(quantity) stringValue];
    InfoModel.unit_price = [@(prict) stringValue];
    InfoModel.tax_rate = [@(taxrate) stringValue];
    NSDecimalNumber *tax_price = [prict1 decimalNumberByMultiplyingBy:taxrate1];
    InfoModel.tax_price = tax_price.stringValue;
    
    NSDecimalNumber *goods_amt = [quantity1 decimalNumberByMultiplyingBy:tax_price];
    InfoModel.goods_amt = goods_amt.stringValue;
    InfoModel.all_amt = goods_amt.stringValue;

    model(InfoModel);
}

#pragma mark -  以含税单价为基准计算
+ (void)FormulaQuantity:(float)quantity taxPrice:(float)taxprice Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model;
{

    DXDAArticleInfoModel *InfoModel = [DXDAArticleInfoModel new];
    InfoModel.amount = [[self FormulataxPricr:taxprice Taxrate:taxrate Quantity:quantity] stringValue];
    InfoModel.quantity = Str_f(quantity);
    InfoModel.unit_price = [[self FormulataxPricr:taxprice Taxrate:taxrate] stringValue];
    InfoModel.tax_rate = Str_f(taxrate);
    InfoModel.tax_price = Str_f(taxprice);
    InfoModel.all_amt = [[self FormulaQuantity:quantity taxPricr:taxprice] stringValue];
    InfoModel.goods_amt = [[self FormulaQuantity:quantity taxPricr:taxprice] stringValue];
    model(InfoModel);
}

#pragma mark -  以数量为基准计算
+ (void)FormulaQuantity:(float)quantity taxPrice:(float)taxprice Price:(float)price Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model
{
    DXDAArticleInfoModel *InfoModel = [DXDAArticleInfoModel new];
    InfoModel.amount = [[self FormulaQuantity:quantity Price:price] stringValue];
    InfoModel.quantity = Str_f(quantity);
    InfoModel.unit_price = Str_f(price);
    InfoModel.tax_rate = Str_f(taxrate);
    InfoModel.tax_price = Str_f(taxprice);
    InfoModel.all_amt = [[self FormulaQuantity:quantity taxPricr:taxprice]stringValue];
    model(InfoModel);
}

#pragma mark -  以金额为基准计算
+ (void)FormulaAmount:(float)amount Quantity:(float)quantity Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model
{
    DXDAArticleInfoModel *InfoModel = [DXDAArticleInfoModel new];
    InfoModel.amount = Str_f(amount);
    InfoModel.quantity = Str_f(quantity);
    InfoModel.unit_price = [[self FormulaAmount:amount Quantity:quantity] stringValue];
    InfoModel.tax_rate = Str_f(taxrate);
    InfoModel.tax_price = [[self FormulaAmount:amount Quantity:quantity Taxrate:taxrate] stringValue];
    InfoModel.all_amt = [[self FormulaAmount:amount Taxrate:taxrate] stringValue];
    model(InfoModel);
}

#pragma mark -  以含税金额为基准计算
+ (void)FormulataxAmount:(float)taxAmount Quantity:(float)quantity Taxrate:(float)taxrate model:(void(^)(DXDAArticleInfoModel *model))model
{
    DXDAArticleInfoModel *InfoModel = [DXDAArticleInfoModel new];
    InfoModel.amount = [[self FormulataxAmount:taxAmount Taxrate:taxrate] stringValue];
    InfoModel.quantity = Str_f(quantity);
    InfoModel.unit_price = [[self FormulataxAmount:taxAmount Quantity:quantity Taxrate:taxrate] stringValue];
    InfoModel.tax_rate = Str_f(taxrate);
    InfoModel.tax_price = [[self FormulataxAmount:taxAmount Quantity:quantity] stringValue];
    InfoModel.all_amt = [[self FormulaAmount:taxAmount Decimals:2] stringValue];
    model(InfoModel);
}


+ (NSNumber *)DXDADigits:(NSNumber*)Digits Float:(float)Float
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:[Digits integerValue]?:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *roundedOunces;
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:roundf(Float)];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *Str = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:Float]];
    NSNumber *Number = [numberFormatter numberFromString:Str];
    
    return Number;
}

#pragma mark - 计算本币金额 - DXDAArticleInfoModel
+(void)calculateAmount:(DXDAArticleInfoModel *)infoModel exchange_rate:(NSString *)exchange_rate{
//    double amount = [infoModel.amount doubleValue]; // 金额
//    double all_amt = amount * (1 + [infoModel.tax_rate doubleValue]); // 价税合计
//    double tax_price = [infoModel.unit_price doubleValue] * (1 + [infoModel.tax_rate floatValue]); // 含税单价
//    double sys_unit_price = [infoModel.unit_price doubleValue] * [exchange_rate doubleValue]; // 本币单价
//    double sys_amount = amount * [exchange_rate doubleValue]; // 本币金额
//    double sys_tax_price = tax_price * [exchange_rate doubleValue]; // 本币含税单价
//    double sys_all_amt = all_amt * [exchange_rate doubleValue]; // 本币含税金额
    
    double sys_unit_price = [infoModel.unit_price doubleValue] * [exchange_rate doubleValue]; // 本币单价
    double sys_amount = infoModel.amount.doubleValue * [exchange_rate doubleValue]; // 本币金额
    double sys_tax_price = infoModel.tax_price.doubleValue * [exchange_rate doubleValue]; // 本币含税单价
    double sys_all_amt = infoModel.all_amt.doubleValue * [exchange_rate doubleValue]; // 本币含税金额
    // 加上折扣率
    CGFloat zk_rate = [infoModel.zk_rate floatValue];
    if (zk_rate>0.00) {
        double sys_amount = infoModel.amount.doubleValue * [exchange_rate doubleValue]; // 本币金额
        double sys_all_amt = infoModel.all_amt.doubleValue * [exchange_rate doubleValue]; // 本币含税金额
        sys_amount = [[NSString stringWithFormat:@"%.2f",sys_amount * zk_rate] doubleValue];
        sys_amount = [[NSString stringWithFormat:@"%.2f",sys_all_amt * zk_rate] doubleValue];
    }
    
//    infoModel.amount = [NSString stringWithFormat:@"%.2f",amount];
//    infoModel.all_amt = [NSString stringWithFormat:@"%.2f",all_amt];
//    infoModel.tax_price = [NSString stringWithFormat:@"%.2f",tax_price];
    infoModel.sys_unit_price = [NSString stringWithFormat:@"%.2f",sys_unit_price];
    infoModel.sys_amount = [NSString stringWithFormat:@"%.2f",sys_amount];
    infoModel.sys_tax_price = [NSString stringWithFormat:@"%.2f",sys_tax_price];
    infoModel.sys_all_amt = [NSString stringWithFormat:@"%.2f",sys_all_amt];

}


@end
