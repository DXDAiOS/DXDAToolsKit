//
//  NSString+DXDANSString_Category.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/22.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSString+DXDANSString_Category.h"
#import "DXDAAddListModel.h"

@implementation NSString (DXDANSString_Category)

+ (NSString *)formatNumber:(CGFloat)number withPointDigits:(int)digits
{
    NSString *formatStr = [NSString stringWithFormat:@"%%0.%df", digits];
    return [NSString stringWithFormat:formatStr, number];
}
//返回单价的小数点位数
+(NSString *)formatNumberWithPriceNumber:(CGFloat)number
{
    UserInfoModel *userInfo = [UserInfoManager sharedUserInfoManager].readUserdata;
    NSString *formatStr = [NSString stringWithFormat:@"%%0.%df", userInfo.price_digit.intValue];
    return [NSString stringWithFormat:formatStr, number];
}
//返回金额的小数点位数
+(NSString *)formatNumberWith_AmountNumber:(CGFloat)number
{
    UserInfoModel *userInfo = [UserInfoManager sharedUserInfoManager].readUserdata;
    NSString *formatStr = [NSString stringWithFormat:@"%%0.%df", userInfo.amount_digit.intValue];
    return [NSString stringWithFormat:formatStr, number];
}
//返回数量小数点位数
+(NSString *)formatWithNumber:(CGFloat)number
{
    UserInfoModel *userInfo = [UserInfoManager sharedUserInfoManager].readUserdata;
    NSString *formatStr = [NSString stringWithFormat:@"%%0.%df", userInfo.dec_digit.intValue];
    return [NSString stringWithFormat:formatStr, number];
}

//MARK: - 字符串只保留数字
+ (NSString *)DXDAAddressStr:(NSString *)str
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z.-]" options:0 error:NULL];
    NSString *result = [regular stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@""];
    NSLog(@"%@",result);
    
    NSString *pureNumbers = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return pureNumbers;
}

//MARK: - 改变部分字符串颜色
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:tempString];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:DXDA_DefaultColor range:range];
    
    return mAttStri;
}

//MARK: - 改变部分字符串颜色
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString color:(UIColor *)color
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:tempString];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return mAttStri;
}

//MARK: - 改变部分字符串颜色
+(NSAttributedString *)changeColorWithString:(NSString *)string firstString:(NSString *)first secondString:(NSString *)second
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range1 = [string rangeOfString:first];
    
    NSRange range2 = [string rangeOfString:second];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:DXDA_DefaultColor range:range1];
    
    [mAttStri addAttribute:NSForegroundColorAttributeName value:DXDA_DefaultColor range:range2];
    
    return mAttStri;
}

//MARK: - 字符串转小写
+(NSString *)toLower:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='A'&[str characterAtIndex:i]<='Z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]+32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

//MARK: - 字符串转大写
+(NSString *)toUpper:(NSString *)str{
    for (NSInteger i=0; i<str.length; i++) {
        if ([str characterAtIndex:i]>='a'&[str characterAtIndex:i]<='z') {
            //A  65  a  97
            char  temp=[str characterAtIndex:i]-32;
            NSRange range=NSMakeRange(i, 1);
            str=[str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}

//MARK: - 改变部分字符串大小
+(NSAttributedString *)changeFontrWithString:(NSString *)string andChangeString:(NSString *)tempString font:(UIFont *)font
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:tempString];
    
    [mAttStri addAttribute:NSFontAttributeName value:font range:range];
    
    return mAttStri;
}

//MARK: - 获取文件路径
+(NSString *)userDataPathWithFileName:(NSString *)fileName
{
    return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
}

//MARK: - 判断手机号码是否正确
- (BOOL)isMobileNumber
{
    if (self.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,152,155,156,170,171,176,185,186
     * 电信号段: 133,134,153,170,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,152,155,156,170,171,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[256]|7[016]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,134,153,170,177,180,181,189
     */
    NSString *CT = @"^1(3[34]|53|7[07]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//MARK: - 判断银行卡号是否正确
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1]intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
    return YES;
}

//MARK: - 判断输入的身份证号是否正确
- (BOOL)checkIdentityCardNo
{
    if (self.length != 18) {
        return  NO;
    }
    
    NSArray* codeArray = @[@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2"];
    
    
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",nil] forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i ,1) ]intValue]* [[codeArray objectAtIndex:i]intValue];
    }
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17,1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}
//MARK: - 判断邮箱是否正确
+ (BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

//MARK: - 返回截取后的字符串
+(NSString *)returnSeparateDate:(NSString *)date {
    date = [date stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSArray *dateArray = [date componentsSeparatedByString:@" "];
    NSString *tempDate = [NSString stringWithFormat:@"%@",dateArray[0]];
    return tempDate ? : @"";
}

//MARK: - 返回string size
+(CGSize)calculateWith:(NSString *)str max:(CGSize)maxSize fontSize:(NSInteger)font {
    if ([str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

/* 返回字符串详细地址 */
+(NSArray *)returnDetailAddress:(NSString *)address
{
    
    NSString * tempStr1 = address;
    NSString * tempStr2 = @"";
    
    NSArray *tempArray = [address componentsSeparatedByString:@"-"];
    
    if (tempArray.count == 3) {
        tempStr1 = [NSString stringWithFormat:@"%@-%@",tempArray[0],tempArray[1]] ;
        tempStr2 = tempArray.lastObject;
    }
    else if (tempArray.count == 4) {
        tempStr1 = [NSString stringWithFormat:@"%@-%@-%@",tempArray[0],tempArray[1],tempArray[2]] ;
        tempStr2 = tempArray.lastObject;
    }
    
    
    return @[tempStr1,tempStr2];
}
//MARK: - 字典转JSON
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//MARK: - Data转JSON
+ (NSString*)hexStringForData:(NSData*)data

{
    
    if (data == nil) {
        
        return nil;
        
    }
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        
        [hexString appendFormat:@"%02x", *p++];
        
    }
    
    return hexString;
}
//MARK: - 数组转JSON
+ (NSString *)arrayToJSONString:(NSArray *)array
{
    if (!array) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}



#pragma mark - 返回审批状态
+(NSString *)returnApproveStateStr:(DXDAAddListModel *)model {
    NSString *stateStr = @"";
    if ([model.Head.approved isEqualToString: @"Y"]) {
        stateStr = @"已审批";
    }
    else if ([model.Head.approved isEqualToString: @"N"]) {
        stateStr = @"待审批";
        if ([model.Common.IsCanApprove isEqualToString:@"N"]) {
            stateStr = @"1级-待审批";
        }
    }
    else if ([model.Head.approved isEqualToString: @"R"]) {
        stateStr = @"已退回";
    }
    else if ([model.Head.approved isEqualToString: @"V"]) {
        stateStr = @"已作废";
    }
    else
    {
        if ([model.Common.IsCanApprove isEqualToString:@"Y"] && [model.Common.IsCanUnApprove isEqualToString:@"N"]) {
            stateStr = [NSString stringWithFormat:@"%ld级-待审批",[model.Head.approved integerValue]+1];
        } else if ([model.Common.IsCanApprove isEqualToString:@"N"] && [model.Common.IsCanUnApprove isEqualToString:@"Y"]) {
            stateStr = [NSString stringWithFormat:@"%ld级-已审批",[model.Head.approved integerValue]];
        } else if ([model.Common.IsCanApprove isEqualToString:@"Y"] && [model.Common.IsCanUnApprove isEqualToString:@"Y"]) {
            stateStr = [NSString stringWithFormat:@"%ld级-待审批",[model.Head.approved integerValue]+1];
        } else if ([model.Common.IsCanApprove isEqualToString:@"N"] && [model.Common.IsCanUnApprove
                                                                        isEqualToString:@"N"]) {
            stateStr = [NSString stringWithFormat:@"%ld级-已审批",[model.Head.approved integerValue]];
        }
    }
    return stateStr;
}

#pragma mark - 返回上链是否成功 string
+(NSString *)returnBlockChainState:(NSInteger)index {
    return index == 2 ? @"确认上链成功" : @"";
}

#pragma mark - 返回转换后 税率名字
+(NSString *)returnEditedTaxName:(DXDAAddListModel *)listModel {
    if (listModel.Head.tax_rate.floatValue == 0) {
        return @"";
    }
    NSString *taxName = [NSString stringWithFormat:@"含税 | %@ | %.2f",listModel.Head.tax_name,float_2(listModel.Head.tax_rate.floatValue)];
    return taxName;
}

#pragma mark - 返回当前出入库类型
+(InOutStockType)returnInOutStockType:(NSString *)type isHead:(BOOL)isHead {
    //MARK: - 出库单
    if ([type isEqualToString:OrderType_CustOrder]) {
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_Shipper]) {
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_PoReturn]) {
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_InvPk]) {
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_InvQc]) {
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_TempShipper]) {
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_Assembly]) {  // 组装单 单身 是出库单  单头 是入库单
        if (isHead) {
            return InOutStockType_inType;
        }
        return InOutStockType_outType;
    }
    else if ([type isEqualToString:OrderType_Disassembly]) {  // 拆卸单 单头 是出库单  单身 是入库单
        if (isHead) {
            return InOutStockType_outType;
        }
        return InOutStockType_inType;
    }
    //MARK: - 入库单
    else if ([type isEqualToString:OrderType_PurchaseOrder]) {
        return InOutStockType_inType;
    }
    else if ([type isEqualToString:OrderType_PurReceipt]) {
        return InOutStockType_inType;
    }
    else if ([type isEqualToString:OrderType_InvQr]) {
        return InOutStockType_inType;
    }
    else if ([type isEqualToString:OrderType_InvPy]) {
        return InOutStockType_inType;
    }
    else if ([type isEqualToString:OrderType_CoReturn]) {
        return InOutStockType_inType;
    }
    else if ([type isEqualToString:OrderType_WoReceipt]) {
        return InOutStockType_inType;
    }
    else if ([type isEqualToString:OrderType_PurTempReceipt]) {
        return InOutStockType_inType;
    }
    return InOutStockType_unknowType;
}


//_typeArray = @[@"增值税发票", // A
//               @"普通发票",  // B
//               @"收据",];   // C
#pragma mark - 返回当前票据类型
+(NSString *)returnInvoiceType:(NSString *)type {
    NSString *tempStr = @"";
    if ([type isEqualToString:@"增值税发票"]) {
        tempStr = @"A";
    }
    else if ([type isEqualToString:@"普通发票"]) {
        tempStr = @"B";
    }
    else if ([type isEqualToString:@"收据"]) {
        tempStr = @"C";
    }
    else if ([type isEqualToString:@"A"]) {
        tempStr = @"增值税发票";
    }
    else if ([type isEqualToString:@"B"]) {
        tempStr = @"普通发票";
    }
    else if ([type isEqualToString:@"C"]) {
        tempStr = @"收据";
    }
    
    return tempStr;
}

#pragma mark - 根据 fun_id 返回 orderType 或者 根据 orderType 返回 fun_id
+(NSString *)returnOrderOrfunType:(NSString *)fun_id {
    
    NSString *order_type = @"";
    
    // 传入 id 返回 类型
    if ([fun_id isEqualToString:Authority_PurchaseOrder]) {
        order_type = OrderType_PurchaseOrder;
    }
    else if ([fun_id isEqualToString:Authority_PurReceipt]) {
        order_type = OrderType_PurReceipt;
    }
    else if ([fun_id isEqualToString:Authority_PoReturn]) {
        order_type = OrderType_PoReturn;
    }
    else if ([fun_id isEqualToString:Authority_PurTempReceipt]) {
        order_type = OrderType_PurTempReceipt;
    }
    else if ([fun_id isEqualToString:Authority_Quote]) {
        order_type = OrderType_Quote;
    }
    else if ([fun_id isEqualToString:Authority_CustOrder]) {
        order_type = OrderType_CustOrder;
    }
    else if ([fun_id isEqualToString:Authority_Shipper]) {
        order_type = OrderType_Shipper;
    }
    else if ([fun_id isEqualToString:Authority_CoReturn]) {
        order_type = OrderType_CoReturn;
    }
    else if ([fun_id isEqualToString:Authority_ShipperNotice]) {
        order_type = OrderType_ShipperNotice;
    }
    else if ([fun_id isEqualToString:Authority_TempShipper]) {
        order_type = OrderType_TempShipper;
    }
    else if ([fun_id isEqualToString:Authority_BuyingRequisition]) {
        order_type = OrderType_Requisition;
    }
    else if ([fun_id isEqualToString:Authority_PurQuote]) {
        order_type = OrderType_PurQuote;
    }
    else if ([fun_id isEqualToString:Authority_PurLogisticsNotice]) {
        order_type = OrderType_PurLogisticsNotice;
    }
    else if ([fun_id isEqualToString:Authority_PurLogistics]) {
        order_type = OrderType_PurLogistics;
    }
    else if ([fun_id isEqualToString:Authority_LogisticsNotice]) {
        order_type = OrderType_LogisticsNotice;
    }
    else if ([fun_id isEqualToString:Authority_WoReceipt]) {
        order_type = OrderType_WoReceipt;
    }
    else if ([fun_id isEqualToString:Authority_ActReceivable]) {
        order_type = OrderType_ActReceivable;
    }
    else if ([fun_id isEqualToString:Authority_ActPayable]) {
        order_type = OrderType_ActPayable;
    }
    else if ([fun_id isEqualToString:Authority_Invoice]) {
        order_type = OrderType_Invoice;
    }
    else if ([fun_id isEqualToString:Authority_PurInvoice]) {
        order_type = OrderType_PurInvoice;
    }
    else if ([fun_id isEqualToString:Authority_ReceNotice]) {
        order_type = OrderType_ReceNotice;
    }
    else if ([fun_id isEqualToString:Authority_ShipperNotice]) {
        order_type = OrderType_ShipperNotice;
    }
    else if ([fun_id isEqualToString:Authority_Payout]){
        order_type = OrderType_Payout;
    }
    else if([fun_id isEqualToString:Authority_PGD]){
        order_type = OrderType_PGD;
    }
    else if ([fun_id isEqualToString:Authority_WorkOrder]){
        order_type = OrderType_WorkOrder;
    }
    
    else if ([fun_id isEqualToString:Authority_ExpenseList]){
        order_type = OrderType_CustCharge;
    }
    else if([fun_id isEqualToString:Authority_PoRtnNotice]){
        order_type = OrderType_PoRtnNotice;;
    }
    else if ([fun_id isEqualToString:Authority_Ticket]){
        order_type = OrderType_TICKET;
    }
    
    
    
    // 传入 类型 返回 id
    else if ([fun_id isEqualToString:OrderType_PurchaseOrder]) {
        order_type = Authority_PurchaseOrder;
    }
    else if ([fun_id isEqualToString:OrderType_PurReceipt]) {
        order_type = Authority_PurReceipt;
    }
    else if ([fun_id isEqualToString:OrderType_PoReturn]) {
        order_type = Authority_PoReturn;
    }
    else if ([fun_id isEqualToString:OrderType_PurTempReceipt]) {
        order_type = Authority_PurTempReceipt;
    }
    else if ([fun_id isEqualToString:OrderType_Quote]) {
        order_type = Authority_Quote;
    }
    else if ([fun_id isEqualToString:OrderType_CustOrder]) {
        order_type = Authority_CustOrder;
    }
    else if ([fun_id isEqualToString:OrderType_Shipper]) {
        order_type = Authority_Shipper;
    }
    else if ([fun_id isEqualToString:OrderType_CoReturn]) {
        order_type = Authority_CoReturn;
    }
    else if ([fun_id isEqualToString:OrderType_ShipperNotice]) {
        order_type = Authority_ShipperNotice;
    }
    else if ([fun_id isEqualToString:OrderType_TempShipper]) {
        order_type = Authority_TempShipper;
    }
    else if ([fun_id isEqualToString:OrderType_Requisition]) {
        order_type = Authority_BuyingRequisition;
    }
    else if ([fun_id isEqualToString:OrderType_PurQuote]) {
        order_type = Authority_PurQuote;
    }
    else if ([fun_id isEqualToString:OrderType_Logistics]) {
        order_type = Authority_Logistics;
    }
    else if ([fun_id isEqualToString:OrderType_PurLogisticsNotice]) {
        order_type = Authority_PurLogisticsNotice;
    }
    else if ([fun_id isEqualToString:OrderType_PurLogistics]) {
        order_type = Authority_PurLogistics;
    }
    else if ([fun_id isEqualToString:OrderType_WoReceipt]) {
        order_type = Authority_WoReceipt;
    }
    else if ([fun_id isEqualToString:OrderType_ActReceivable]) {
        order_type = Authority_ActReceivable;
    }
    else if ([fun_id isEqualToString:OrderType_ActPayable]) {
        order_type = Authority_ActPayable;
    }
    else if ([fun_id isEqualToString:OrderType_LogisticsNotice]) {
        order_type = Authority_LogisticsNotice;
    }
    else if ([fun_id isEqualToString:OrderType_Invoice]) {
        order_type = Authority_Invoice;
    }
    else if ([fun_id isEqualToString:OrderType_PurInvoice]) {
        order_type = Authority_PurInvoice;
    }
    else if ([fun_id isEqualToString:OrderType_ReceNotice]) {
        order_type = Authority_ReceNotice;
    }
    else if ([fun_id isEqualToString:OrderType_ShipperNotice]) {
        order_type = Authority_ShipperNotice;
    }
    else if ([fun_id isEqualToString:OrderType_Payout]){
        order_type = Authority_Payout;
    }
    else if([fun_id isEqualToString:OrderType_PGD]){
        order_type = Authority_PGD;
    }
    else if ([fun_id isEqualToString:OrderType_CustCharge]){
        order_type = Authority_ExpenseList;
    }
    else if ([fun_id isEqualToString:OrderType_PoRtnNotice]){
        order_type = Authority_PoRtnNotice;
    }
    else if ([fun_id isEqualToString:OrderType_TICKET]){
        order_type = Authority_Ticket;
    }
    
    return order_type;
}

#pragma mark - 返回上级单号
+(NSString *)returnUpperNumber:(DXDAArticleInfoModel *)infoModel {
    NSString *upper_no = @"";
    
    //MARK: - 报价单 上级单号
    if (infoModel.quote_no.length > 0) {
        upper_no = infoModel.quote_no;
    }
    //MARK: - 请购单 上级单号
    else if (infoModel.rqt_no.length > 0) {
        upper_no = infoModel.rqt_no;
    }
    //MARK: - 通知单 上级单号
    else if (infoModel.notice_no.length > 0) {
        upper_no = infoModel.notice_no;
    }
    //MARK: - 订单 上级单号
    else if (infoModel.order_no.length > 0) {
        upper_no = infoModel.order_no;
    }
    //MARK: - 销售发货单 上级单号
    else if (infoModel.shipper_no.length > 0) {
        upper_no = infoModel.shipper_no;
    }
    //MARK: - 采购收货单 上级单号
    else if (infoModel.receipt_no.length > 0) {
        upper_no = infoModel.receipt_no;
    }
    //MARK: - 销售暂发单 上级单号
    else if (infoModel.temp_shipper_no.length > 0) {
        upper_no = infoModel.temp_shipper_no;
    }

    return upper_no;
}

//MARK: - 未分配（N）、已分配（A）、已转换（Y）、已作废（V）
+(NSString *)returnCRMStatus:(NSString *)status {
    NSString *string = @"";
    if ([status isEqualToString:@"N"]) {
        string = @"未分配";
    }
    else if ([status isEqualToString:@"A"]) {
        string = @"已分配";
    }
    else if ([status isEqualToString:@"Y"]) {
        string = @"已转换";
    }
    else if ([status isEqualToString:@"V"]) {
        string = @"已作废";
    }
    else if ([status isEqualToString:@"F"]) {
        string = @"跟进中";
    }
    else
    {
        string = @"未分配";
    }
    return string;
}

//MARK: - 所有（W）；待签退（O）、待记录（R）、审批中（A）、已完成（Y）
+(NSString *)returnLegworkStatus:(NSString *)status {
    NSString *string = @"";
    if ([status isEqualToString:@"W"]) {
        string = @"全部";
    }
    else if ([status isEqualToString:@"O"]) {
        string = @"待签退";
    }
    else if ([status isEqualToString:@"R"]) {
        string = @"待记录";
    }
    else if ([status isEqualToString:@"A"]) {
        string = @"审批中";
    }
    else if ([status isEqualToString:@"Y"]) {
        string = @"已完成";
    }
    else
    {
        string = @"未完成";
    }
    return string;
}

//未完成（N）、审批中（A）、已签到（I）、已签退（O）、已开拜访总结（S）、已完成（Y）
+ (NSString *)returnVisitStatus:(NSString *)string {
    if ([string isEqualToString:@"N"]) {
        return @"未完成";
    }
    else if ([string isEqualToString:@"Y"]) {
        return @"已完成";
    }
    else if ([string isEqualToString:@"A"]) {
        return @"审批中";
    }
    else if ([string isEqualToString:@"I"]) {
        return @"已签到";
    }
    else if ([string isEqualToString:@"O"]) {
        return @"已签退";
    }
    else if ([string isEqualToString:@"S"]) {
        return @"已开拜访总结";
    }
    return @"";
}

//MARK: - 所有（W）；已完成（Y）；待审批（N）；已退回（R）;已作废（V）
+(NSString *)returnLegworkApproveStatus:(NSString *)status {
    NSString *string = @"";
    if ([status isEqualToString:@"W"]) {
        string = @"全部";
    }
    else if ([status isEqualToString:@"Y"]) {
        string = @"已完成";
    }
    else if ([status isEqualToString:@"N"]) {
        string = @"待审批";
    }
    else if ([status isEqualToString:@"R"]) {
        string = @"已退回";
    }
    else if ([status isEqualToString:@"V"]) {
        string = @"已作废";
    }
    
    return string;
}

//MARK: - 全部（A） 已审批（Y）；待审批（N）；已退回（R）;已作废（V）
+(NSString *)returnApproveStatus:(NSString *)status {
    NSString *string = @"";
    if ([status isEqualToString:@"A"]) {
        string = @"全部";
    }
    else if ([status isEqualToString:@"Y"]) {
        string = @"已审批";
    }
    else if ([status isEqualToString:@"N"]) {
        string = @"待审批";
    }
    else if ([status isEqualToString:@"R"]) {
        string = @"已退回";
    }
    else if ([status isEqualToString:@"V"]) {
        string = @"已作废";
    }
    
    return string;
}

//MARK: 已作废（Y） 已作废（已处理）
+(NSString *)returnCRMCustomerStatus:(NSString *)status
{
    NSString *string = @"";
    if ([status isEqualToString:@"Y"]) {
        string = @"已作废";
    }
    else {
        string = @"已处理";
    }
    return string;
}

//MARK: 跟进记录
+(NSString *)returnCurrentFollowType:(NSString *)type {
    if ([type isEqualToString:@"Disable"]) {
        return @"作废";
    }
    else if ([type isEqualToString:@"Able"]) {
        return @"激活";
    }
    else if ([type isEqualToString:@"ReturnCue"]) {
        return @"退回线索池";
    }
    else if ([type isEqualToString:@"ChangeSaleman"]) {
        return @"更换业务员";
    }
    else if ([type isEqualToString:@"TransCustomer"]) {
        return @"转换客户";
    }
    else if ([type isEqualToString:@"Allot"]) {
        return @"分配";
    }
    else if ([type isEqualToString:@"Get"]) {
        return @"领取";
    }
    else if ([type isEqualToString:@"SaleCue"]||[type isEqualToString:@"Customer"]) {
        return @"编辑";
    }
    else if ([type isEqualToString:OrderType_CustLinkMan]) {
        return @"联系人";
    }
    else if ([type isEqualToString:OrderType_ShiptoAddr]) {
        return @"发货地址";
    }
    else if ([type isEqualToString:OrderType_Cust_Ad_File]) {
        return @"附件";
    }
    else if ([type isEqualToString:Authority_Quote]) {
        return @"销售报价";
    }
    else if ([type isEqualToString:OrderType_CustOrder]) {
        return @"销售订单";
    }
    else if ([type isEqualToString:OrderType_Shipper]) {
        return @"发货单";
    }
    else if ([type isEqualToString:OrderType_Invoice]) {
        return @"销售发票";
    }
    else if ([type isEqualToString:OrderType_ActReceivable]) {
        return @"应收单";
    }
    else if ([type isEqualToString:OrderType_Cash]) {
        return @"收款单";
    }
    else if ([type isEqualToString:OrderType_CustomerFollow]) {
        return @"客户联络单";
    }
    
    return @"";
}

//MARK: - 1、日程拜访；2、日常盘点；3、巡店拜访；4促销执行；5、临时拜访；6、其他
+ (NSString *)returnCRMVisitType:(NSString *)index {
    if (index.length == 0) {
        return @"";
    }
    
    if (index.length > 1) {
        if ([index isEqualToString:@"日程拜访"]) {
            return @"1";
        }
        else if ([index isEqualToString:@"日常盘点"]) {
            return @"2";
        }
        else if ([index isEqualToString:@"巡店拜访"]) {
            return @"3";
        }
        else if ([index isEqualToString:@"促销执行"]) {
            return @"4";
        }
        else if ([index isEqualToString:@"临时拜访"]) {
            return @"5";
        }
        else if ([index isEqualToString:@"其他"]) {
            return @"6";
        }
    }
    
    if (index.integerValue == 1) {
        return @"日程拜访";
    }
    else if (index.integerValue == 2) {
        return @"日常盘点";
    }
    else if (index.integerValue == 3) {
        return @"巡店拜访";
    }
    else if (index.integerValue == 4) {
        return @"促销执行";
    }
    else if (index.integerValue == 5) {
        return @"临时拜访";
    }
    else if (index.integerValue == 6) {
        return @"其他";
    }
    else {
        return @"";
    }
}

//MARK: - 商机状态 灭失（V）；进行中（I或者为空）；输单（N）；赢单（Y）
+(NSString *)returnCRMOpportunityStatus:(NSString *)status {
    NSString *string = @"";
    if ([status isEqualToString:@"V"]) {
        string = @"灭失";
    }
    else if ([status isEqualToString:@"I"] || [status isEqualToString:@""]) {
        string = @"进行中";
    }
    else if ([status isEqualToString:@"N"]) {
        string = @"输单";
    }
    else if ([status isEqualToString:@"Y"]) {
        string = @"赢单";
    }
    else {}

    return string;
}

//MARK: - 阶段状态 未开始（N）；已完成（Y）；审批中（S）；进行中（I）; 灭失（V）; 赢单（G）; 输单（L）
+(NSString *)returnCRMStageStatus:(NSString *)status {
    NSString *string = @"";
    if ([status isEqualToString:@"N"]) {
        string = @"未开始";
    }
    else if ([status isEqualToString:@"Y"]) {
        string = @"已完成";
    }
    else if ([status isEqualToString:@"S"]) {
        string = @"审批中";
    }
    else if ([status isEqualToString:@"I"]) {
        string = @"进行中";
    }
    else if ([status isEqualToString:@"V"] || [status isEqualToString:@"G"] || [status isEqualToString:@"L"]) {
        string = @"已结束";//@"灭失";
    }
//    else if ([status isEqualToString:@"G"]) {
//        string = @"赢单";
//    }
//    else if ([status isEqualToString:@"L"]) {
//        string = @"输单";
//    }
    else {}
    
    return string;
}

+(NSString *)returnOrderPurOrSalesType:(NSString *)string
{
    if ([string isEqualToString:@"请购单"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购询价"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购报价"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购订单"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"收货通知单"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购物流单"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购物流通知单"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购收货"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购发票"]) {
        return @"Purchase";
    }
    else if ([string isEqualToString:@"应付账单"]){
        return @"Purchase";
    }
    else if ([string isEqualToString:@"采购退货单"]){
        return @"Purchase";
    }
    
    else if ([string isEqualToString:@"销售退货单"]){
        return @"Sales";
    }
    else if ([string isEqualToString:@"销售报价"]) {
        return @"Sales";
    }
    else if ([string isEqualToString:@"订单录入"]) {
        return @"Sales";
    }
    else if ([string isEqualToString:@"发货通知单"]) {
        return @"Sales";
    }
    else if ([string isEqualToString:@"销售物流通知单"]) {
        return @"Sales";
    }
    else if ([string isEqualToString:@"销售物流单"]) {
        return @"Sales";
    }
    else if ([string isEqualToString:@"销售发货"]) {
        return @"Sales";
    }
    else if ([string isEqualToString:@"销售发票"]) {
        return @"Sales";
    }
    else if([string isEqualToString:@"应收账单"]) {
        return @"Sales";
    }
    
    else if ([string isEqualToString:@"费用申请单"]){
        return @"CustCharge";
    }
    
    
    
    return @"";
}

@end
