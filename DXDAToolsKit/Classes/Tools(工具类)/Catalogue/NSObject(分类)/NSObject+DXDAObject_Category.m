//
//  NSObject+DXDAObject_Category.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/22.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSObject+DXDAObject_Category.h"
#import "DXDATaxModel.h"
#import "DXDAAddListModel.h"
#import "DXDABusinessInfoModel.h"

@implementation NSObject (DXDAObject_Category)

//MARK: - 保留小数点 2位
+(CGFloat)floatType:(CGFloat)value {
//    NSString *switchStr = [NSString stringWithFormat:@"%.2f",value];
//    return switchStr.doubleValue;
    return value;
}

+ (NSString *)ChineseWithInteger:(NSInteger)integer
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:(int)integer]];
    return string;
}

+(NSString *)jia_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two
{
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:one];
    NSDecimalNumber  *number2 = [NSDecimalNumber decimalNumberWithString:two];
    NSDecimalNumber *num = [number2 decimalNumberByAdding:number1];
    return num.stringValue;
}
+(NSString *)jian_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two
{
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:one];
    NSDecimalNumber  *number2 = [NSDecimalNumber decimalNumberWithString:two];
    NSDecimalNumber *num = [number1 decimalNumberBySubtracting:number2];
    return num.stringValue;
}
+(NSString *)cheng_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two
{
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:one];
    NSDecimalNumber  *number2 = [NSDecimalNumber decimalNumberWithString:two];
    NSDecimalNumber *num = [number1 decimalNumberByMultiplyingBy:number2];
    return num.stringValue;
}
+(NSString *)chu_returnFloatWithNumber1:(NSString *)one Number2:(NSString *)two
{
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:one];
    NSDecimalNumber  *number2 = [NSDecimalNumber decimalNumberWithString:two];
    NSDecimalNumber *num = [number1 decimalNumberByDividingBy:number2];
    return num.stringValue;
}

//MARK: - 判断是否可以跳转
+(BOOL)judgeCurrentControllerCanPush:(NSString *)controllerTitle {
    if ([controllerTitle containsString:@"账单"] ||
        [controllerTitle containsString:@"款单"] ||
        [controllerTitle containsString:@"报表"]) {
        
        return YES;
    }
    return NO;
}

//MARK: - 改变 单头 的 税目信息
+(void)changeHeadTaxInfos:(DXDAAddListModel *)listModel taxModel:(id)model {
    if ([model isKindOfClass:[DXDABusinessInfoModel class]]) {
        DXDABusinessInfoModel *businessModel = model;
        listModel.Head.tax_id = businessModel.tax_id ? : @"";
        listModel.Head.tax_rate = businessModel.tax_rate ? : @"";
        listModel.Head.tax_name = businessModel.tax_name ? : @"";
    }
    else if ([model isKindOfClass:[DXDATaxModel class]]) {
        DXDATaxModel *taxModel = model;
        listModel.Head.tax_id = taxModel.tax_id ? : @"";
        listModel.Head.tax_rate = taxModel.tax_rate ? :@"";
        listModel.Head.tax_name = taxModel.tax_name ? : @"";
    }
    else if (model == nil){
        listModel.Head.tax_id = @"";
        listModel.Head.tax_rate = @"";
        listModel.Head.tax_name = @"";
    }
}

//MARK: - 改变 单身 的 税目信息
+(void)changeBodyTaxInfos:(DXDAAddListModel *)listModel {
    for (DXDAArticleInfoModel *infoModel in listModel.Body) {
        infoModel.tax_id = listModel.Head.tax_id;
        infoModel.tax_rate = listModel.Head.tax_rate;
        infoModel.tax_name = listModel.Head.tax_name;
        infoModel.tax_price = [[NSObject FormulaPricr:infoModel.unit_price.floatValue Taxrate:listModel.Head.tax_rate.floatValue] stringValue];
        
        double all_amt = infoModel.tax_price.doubleValue * infoModel.quantity.doubleValue;
        infoModel.all_amt = [[NSObject FormulaAmount:all_amt Decimals:2] stringValue];
        
        // 加上折扣率
        CGFloat zk_rate = [infoModel.zk_rate floatValue];
        if (zk_rate>0.00) {
            infoModel.all_amt = [NSString stringWithFormat:@"%.2f",[infoModel.all_amt floatValue] * zk_rate];
        }
    }
}


@end
