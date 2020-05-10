//
//  UserInfoModel.h
//  RxdaApp
//
//  Created by Erowin on 16/9/9.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject<NSCoding,NSCopying>
/**
 *   用户账号
 */
@property(nonatomic,copy)NSString *strUserID;
/**
 *   用户账号手机号码
 */
@property(nonatomic,copy)NSString *mobUserID;
/**
 *   用户密码
 */
@property(nonatomic,copy)NSString *strUserPWD;
/**
 *  企业名称
 */
@property(nonatomic,copy)NSString *chn_name;
/**
 *  企业地址
 */
@property(nonatomic,copy)NSString *cust_add;
/**
 *  联系电话
 */
@property(nonatomic,copy)NSString *mob_no;
/**
 *  头像URL
 */
@property(nonatomic,strong)NSString *icon_image;
/**
 *  头像的二进制
 */
@property(nonatomic,strong)NSData *icon_Data;
///平台ID
@property(nonatomic,copy)NSString *Platform_ID;

@property(nonatomic,copy)NSString *linkman;
@property(nonatomic,copy)NSString *entity_id;
@property(nonatomic,copy)NSString *zipcode;
@property(nonatomic,copy)NSString *custAdd;
//是否自动登录
@property(nonatomic,assign)BOOL isAutomatiNSLogin;
//是否是江铜项目
@property(nonatomic,assign)BOOL isJTong;

//===============================新接口新增修改使用字段，原字段保留xzp============
//账号区
@property (nonatomic, copy)NSString *Chn_Addr;
//账号省
@property (nonatomic, copy)NSString *State;
//账号市
@property (nonatomic, copy)NSString *City;
//用户ID
@property (nonatomic, copy)NSString *User_ID;
//邮编
@property (nonatomic, copy)NSString *Zip_Code;
//公司头像
@property (nonatomic, copy)NSString *Company_Icon;
//公司logo
@property (nonatomic, copy)NSString *Company_Logo;
//用户密码
@property (nonatomic, copy)NSString *User_PWD;
//企业名称
@property (nonatomic, copy)NSString *Company_Name;
//用户;
@property (nonatomic, copy)NSString *User_Name;
@property (nonatomic, copy)NSString *keyid;
//管理员名称
@property (nonatomic, copy)NSString *Link_Man;
//汇率   1.currency_id 汇率单位 2.exchange_rate 汇率 3.exchange_rage_digit
@property (nonatomic, copy)NSDictionary *SysCurrency;
//广告图片
@property (nonatomic, copy)NSArray *AppBanner;

//账户电话
@property (nonatomic, copy)NSString *Mob_No;

@property (nonatomic, copy)NSString *use_code_login_erp;

//自定义域名
@property (nonatomic, copy)NSString *useIPText;
@property (nonatomic, assign)BOOL isUseIP;

//===========================NSDictionary *SysCurrency===================
/*1.currency_id 汇率单位
 *2.exchange_rate 汇率
 *3.exchange_rage_digit  汇率的小数位
 *amount_digit 金额小数位数
 *price_digit 单价小数位数
 suffix_currency 前缀符号
 */
@property (nonatomic, strong) NSString *amount_digit;
@property (nonatomic, strong) NSString *dec_digit;  
@property (nonatomic, strong) NSString *exchange_rage_digit;
@property (nonatomic, strong) NSString *exchange_rate;
@property (nonatomic, strong) NSString *price_digit;
@property (nonatomic, strong) NSString *currency_id;
@property (nonatomic, strong) NSString *currency_name;
@property (nonatomic, strong) NSString *suffix_currency;
//========================================================================

@property (nonatomic, copy) NSString *loginTime;

+(instancetype)UserInfoModelWithDic:(NSDictionary *)dic;
-(instancetype)initWithdic:(NSDictionary *)dic;
@end
