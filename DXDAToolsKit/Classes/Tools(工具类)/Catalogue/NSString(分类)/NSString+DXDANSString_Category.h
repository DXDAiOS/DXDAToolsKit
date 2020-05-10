//
//  NSString+DXDANSString_Category.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/22.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DXDAAddListModel;

@interface NSString (DXDANSString_Category)

#pragma mark -  ----------- 字符串处理
/**
 * 保留几位小数
 * @param number 数 digits 几位
 * @return 返回字符串
 */
+ (NSString *)formatNumber:(CGFloat)number withPointDigits:(int)digits;
+(NSString *)formatNumberWithPriceNumber:(CGFloat)number;//单价的小数位
+(NSString *)formatNumberWith_AmountNumber:(CGFloat)number;//金额的小数位
+(NSString *)formatWithNumber:(CGFloat)number;//返回数量小数点位数
/**
 * 字符串只保留数字
 * @param str 要剔除的字符串
 * @return 返回只保留数字的字符串
 */
+ (NSString *)DXDAAddressStr:(NSString *)str;
/**
 * 计算字符串宽高
 * @param str 字符串
 * @param maxSize 字符串
 * @param font 字体大小
 * @return 字符串宽高
 */
+(CGSize)calculateWith:(NSString *)str max:(CGSize)maxSize fontSize:(NSInteger)font;

/**
 * 字符串转小写
 * @param str 字符串
 * @return 全小写字符串
 */
+(NSString *)toLower:(NSString *)str;

/**
 * 字符串转大写
 * @param str 字符串
 * @return 全大写字符串
 */
+(NSString *)toUpper:(NSString *)str;

/**
 * 返回截取后的字符串
 */
+(NSString *)returnSeparateDate:(NSString *)date;

/**
 * 返回字符串详细地址数组
 */
+(NSArray *)returnDetailAddress:(NSString *)address;
#pragma mark -  ----------- 字体大小
/**
 * 改变部分字符串大小
 * @param string 要改变颜色的字符串
 * @param tempString 改变部分
 * @return 返回字体大小字符串
 */

+(NSAttributedString *)changeFontrWithString:(NSString *)string andChangeString:(NSString *)tempString font:(UIFont *)font;

#pragma mark -  ----------- 字体颜色
/**
 * 改变部分字符串颜色
 * @param string 要改变颜色的字符串
 * @param tempString 改变部分
 * @return 返回颜色字符串
 */
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString;

/**
 * 改变部分字符串颜色
 * @param string 要改变颜色的字符串
 * @param tempString 改变部分
 * @param color 改变颜色
 * @return 返回颜色字符串
 */
+(NSAttributedString *)changeColorWithString:(NSString *)string andChangeString:(NSString *)tempString color:(UIColor *)color;

/**
 * 改变部分字符串颜色
 * @param string 要改变颜色的字符串
 * @param first 改变部分
 * @return 返回颜色字符串
 */
+(NSAttributedString *)changeColorWithString:(NSString *)string firstString:(NSString *)first secondString:(NSString *)second;


#pragma mark -  ----------- 文件路径
/**
 * 获取文件路径
 * @param fileName 文件名
 * @return 文件路径
 */
+(NSString *)userDataPathWithFileName:(NSString *)fileName;


#pragma mark -  ----------- 字符串判断 （手机／银行卡／身份证／邮箱）
/**
 *  判断手机号码是否正确
 */
- (BOOL)isMobileNumber;
/**
 *  判断银行账号是否正确
 */
+ (BOOL) checkCardNo:(NSString*)cardNo;
/**
 *  判断身份证是否正确
 */
- (BOOL)checkIdentityCardNo;
/**
 *  判断邮箱是否正确
 */
+ (BOOL)isValidateEmail:(NSString *)email;

#pragma mark -  ----------- 转json （Array／Data／Dictionary）
/**
 *  字典转JSON
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 *  Data转JSON
 */
+ (NSString*)hexStringForData:(NSData*)data;
/**
 *  数组转JSON
 */
+ (NSString *)arrayToJSONString:(NSArray *)array;

#pragma mark - 返回审批状态
+(NSString *)returnApproveStateStr:(DXDAAddListModel *)model;

#pragma mark - 返回上链是否成功 string
+(NSString *)returnBlockChainState:(NSInteger)index;

#pragma mark - 返回转换后 税率名字
+(NSString *)returnEditedTaxName:(DXDAAddListModel *)listModel;

#pragma mark - 返回当前票据类型
+(NSString *)returnInvoiceType:(NSString *)type;

#pragma mark - 根据 fun_id 返回 orderType 或者 根据 orderType 返回 fun_id
+(NSString *)returnOrderOrfunType:(NSString *)fun_id;

#pragma mark - 返回上级单号
+(NSString *)returnUpperNumber:(DXDAArticleInfoModel *)infoModel;

#pragma mark - 返回当前出入库类型
/**
 返回当前出入库类型

 @param type orderType 类型
 @param isHead 是否单头，只对 组装单、拆卸单用
 @return 返回 出入库类型
 */
+(InOutStockType)returnInOutStockType:(NSString *)type isHead:(BOOL)isHead;

//MARK: - 未分配（N）、已分配（A）、已转换（Y）、已作废（V）
+(NSString *)returnCRMStatus:(NSString *)status;

//MARK: - 所有（W）；待签退（O）、待记录（R）、审批中（A）、已完成（Y）
+(NSString *)returnLegworkStatus:(NSString *)status;

//MARK: - 所有（W）；已完成（Y）；待审批（N）；已退回（R）;已作废（V）
+(NSString *)returnLegworkApproveStatus:(NSString *)status;

//未完成（N）、审批中（A）、已签到（I）、已签退（O）、已开拜访总结（S）、已完成（Y）
+ (NSString *)returnVisitStatus:(NSString *)string;

//MARK: - 已审批（Y）；待审批（N）；已退回（R）;已作废（V）
+(NSString *)returnApproveStatus:(NSString *)status;

//MARK: 已作废（Y） 已作废（已处理）
+(NSString *)returnCRMCustomerStatus:(NSString *)status;

//MARK: 跟进记录
+(NSString *)returnCurrentFollowType:(NSString *)type;

//MARK: - 1、日程拜访；2、日常盘点；3、巡店拜访；4促销执行；5、临时拜访；6、其他
+ (NSString *)returnCRMVisitType:(NSString *)index;

//MARK: - 商机状态 灭失（V）；进行中（I或者为空）；输单（N）；赢单（Y）
+(NSString *)returnCRMOpportunityStatus:(NSString *)status;

//MARK: - 阶段状态 未开始（N）；已完成（Y）；审批中（S）；进行中（I）; 灭失（V）; 赢单（G）; 输单（L）
+(NSString *)returnCRMStageStatus:(NSString *)status;

//MARK: - 判断是销售类型还是采购类型订单
+(NSString *)returnOrderPurOrSalesType:(NSString *)string;
@end
