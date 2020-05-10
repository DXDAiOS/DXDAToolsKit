//
//  UserInfoModel.m
//  RxdaApp
//
//  Created by Erowin on 16/9/9.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "UserInfoModel.h"

///**
// *   用户账号
// */
//@property(nonatomic,copy)NSString *strUserID;
///**
// *   用户密码
// */
//@property(nonatomic,copy)NSString *strUserPWD;
///**
// *  企业名称
// */
//@property(nonatomic,copy)NSString *chn_name;
///**
// *  企业地址
// */
//@property(nonatomic,copy)NSString *chn_addr;
///**
// *  联系电话
// */
//@property(nonatomic,copy)NSString *mob_no;
///**
// *  头像URL
// */
//@property(nonatomic,copy)NSString *icon_image;

@implementation UserInfoModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.strUserID forKey:@"strUserID"];
    [aCoder encodeObject:self.strUserPWD forKey:@"strUserPWD"];
    [aCoder encodeObject:self.chn_name forKey:@"chn_name"];
    [aCoder encodeObject:self.cust_add forKey:@"cust_add"];
    [aCoder encodeObject:self.mob_no forKey:@"mob_no"];
    [aCoder encodeObject:self.use_code_login_erp forKey:@"use_code_login_erp"];
    [aCoder encodeObject:self.icon_image forKey:@"icon_image"];
    [aCoder encodeObject:self.entity_id forKey:@"entity_id"];
    [aCoder encodeBool:self.isAutomatiNSLogin forKey:@"isAutomatiNSLogin"];
    [aCoder encodeBool:self.isJTong forKey:@"isJTong"];
    [aCoder encodeObject:self.linkman forKey:@"linkman"];
    [aCoder encodeObject:self.zipcode forKey:@"zipcode"];
    [aCoder encodeObject:self.custAdd forKey:@"custAdd"];
    [aCoder encodeObject:self.icon_Data forKey:@"icon_Data"];
    [aCoder encodeObject:self.Platform_ID forKey:@"Platform_ID"];
    [aCoder encodeObject:self.mobUserID forKey:@"mobUserID"];
    
    [aCoder encodeObject:self.Chn_Addr forKey:@"Chn_Addr"];
    [aCoder encodeObject:self.State forKey:@"State"];
    [aCoder encodeObject:self.City forKey:@"City"];
    [aCoder encodeObject:self.User_ID forKey:@"User_ID"];
    [aCoder encodeObject:self.Zip_Code forKey:@"Zip_Code"];
    [aCoder encodeObject:self.Company_Icon forKey:@"Company_Icon"];
    [aCoder encodeObject:self.Company_Logo forKey:@"Company_Logo"];
    [aCoder encodeObject:self.User_PWD forKey:@"User_PWD"];
    [aCoder encodeObject:self.Company_Name forKey:@"Company_Name"];
    [aCoder encodeObject:self.User_Name forKey:@"User_Name"];
    [aCoder encodeObject:self.Link_Man forKey:@"Link_Man"];
    [aCoder encodeObject:self.Mob_No forKey:@"Mob_No"];
    [aCoder encodeObject:self.amount_digit forKey:@"amount_digit"];
    [aCoder encodeObject:self.dec_digit forKey:@"dec_digit"];
    [aCoder encodeObject:self.exchange_rage_digit forKey:@"exchange_rage_digit"];
    [aCoder encodeObject:self.exchange_rate forKey:@"exchange_rate"];
    [aCoder encodeObject:self.price_digit forKey:@"price_digit"];
    [aCoder encodeObject:self.currency_id forKey:@"currency_id"];
    [aCoder encodeObject:self.currency_name forKey:@"currency_name"];
    [aCoder encodeObject:self.suffix_currency forKey:@"suffix_currency"];
    [aCoder encodeObject:self.SysCurrency forKey:@"SysCurrency"];
    [aCoder encodeObject:self.AppBanner forKey:@"AppBanner"];
    [aCoder encodeObject:self.useIPText forKey:@"useIPText"];
    [aCoder encodeBool:self.isUseIP forKey:@"isUseIP"];
    [aCoder encodeBool:self.keyid forKey:@"keyid"];
    

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.strUserID = [aDecoder decodeObjectForKey:@"strUserID"];
    self.strUserPWD = [aDecoder decodeObjectForKey:@"strUserPWD"];
    self.chn_name = [aDecoder decodeObjectForKey:@"chn_name"];
    self.cust_add = [aDecoder decodeObjectForKey:@"cust_add"];
    self.mob_no = [aDecoder decodeObjectForKey:@"mob_no"];
    self.use_code_login_erp = [aDecoder decodeObjectForKey:@"use_code_login_erp"];
    self.icon_image = [aDecoder decodeObjectForKey:@"icon_image"];
    self.entity_id = [aDecoder decodeObjectForKey:@"entity_id"];
    self.isAutomatiNSLogin = [aDecoder decodeObjectForKey:@"isAutomatiNSLogin"];
    self.isAutomatiNSLogin = [aDecoder decodeBoolForKey:@"isAutomatiNSLogin"];
    self.isJTong = [aDecoder decodeObjectForKey:@"isJTong"];
    self.linkman = [aDecoder decodeObjectForKey:@"linkman"];
    self.zipcode = [aDecoder decodeObjectForKey:@"zipcode"];
    self.custAdd = [aDecoder decodeObjectForKey:@"custAdd"];
    self.icon_Data = [aDecoder decodeObjectForKey:@"icon_Data"];
    self.Platform_ID = [aDecoder decodeObjectForKey:@"Platform_ID"];
    self.mobUserID = [aDecoder decodeObjectForKey:@"mobUserID"];
    
    self.Chn_Addr = [aDecoder decodeObjectForKey:@"Chn_Addr"];
    self.State = [aDecoder decodeObjectForKey:@"State"];
    self.City = [aDecoder decodeObjectForKey:@"City"];
    self.User_ID = [aDecoder decodeObjectForKey:@"User_ID"];
    self.Zip_Code = [aDecoder decodeObjectForKey:@"Zip_Code"];
    self.Company_Icon = [aDecoder decodeObjectForKey:@"Company_Icon"];
    self.Company_Logo = [aDecoder decodeObjectForKey:@"Company_Logo"];
    self.User_PWD = [aDecoder decodeObjectForKey:@"User_PWD"];
    self.Company_Name = [aDecoder decodeObjectForKey:@"Company_Name"];
    self.User_Name = [aDecoder decodeObjectForKey:@"User_Name"];
    self.Link_Man = [aDecoder decodeObjectForKey:@"Link_Man"];
    self.Mob_No = [aDecoder decodeObjectForKey:@"Mob_No"];
    self.amount_digit = [aDecoder decodeObjectForKey:@"amount_digit"];
    self.dec_digit = [aDecoder decodeObjectForKey:@"dec_digit"];
    self.exchange_rage_digit = [aDecoder decodeObjectForKey:@"exchange_rage_digit"];
    self.exchange_rate = [aDecoder decodeObjectForKey:@"exchange_rate"];
    self.price_digit = [aDecoder decodeObjectForKey:@"price_digit"];
    self.currency_id = [aDecoder decodeObjectForKey:@"currency_id"];
    self.currency_name = [aDecoder decodeObjectForKey:@"currency_name"];
    self.suffix_currency = [aDecoder decodeObjectForKey:@"suffix_currency"];
    self.SysCurrency = [aDecoder decodeObjectForKey:@"SysCurrency"];
    self.AppBanner = [aDecoder decodeObjectForKey:@"AppBanner"];
    self.useIPText = [aDecoder decodeObjectForKey:@"useIPText"];
    self.isUseIP = [aDecoder decodeObjectForKey:@"isUseIP"];
    self.keyid = [aDecoder decodeObjectForKey:@"keyid"];
    
    

    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    UserInfoModel *instance = [[UserInfoModel alloc] init];
    if (instance) {
      
        instance.strUserID = [self.strUserID copyWithZone:zone];
        instance.strUserPWD = [self.strUserPWD copyWithZone:zone];
        instance.chn_name = [self.chn_name copyWithZone:zone];
        instance.cust_add = [self.cust_add copyWithZone:zone];
        instance.mob_no = [self.mob_no copyWithZone:zone];
        instance.use_code_login_erp = [self.use_code_login_erp copyWithZone:zone];
        instance.icon_image = [self.icon_image copyWithZone:zone];
        instance.entity_id = [self.entity_id copyWithZone:zone];
        instance.isAutomatiNSLogin = self.isAutomatiNSLogin;
        instance.isJTong = self.isJTong;
        instance.linkman = [self.linkman copyWithZone:zone];
        instance.zipcode = [self.zipcode copyWithZone:zone];
        instance.custAdd = [self.custAdd copyWithZone:zone];
        instance.icon_Data = [self.icon_Data copyWithZone:zone];
        
        instance.Platform_ID = [self.Platform_ID copyWithZone:zone];
        
        instance.mobUserID = [self.mobUserID copyWithZone:zone];
        instance.Chn_Addr = [self.Chn_Addr copyWithZone:zone];
        instance.State = [self.State copyWithZone:zone];
        instance.City = [self.City copyWithZone:zone];
        instance.User_ID = [self.User_ID copyWithZone:zone];
        instance.Zip_Code = [self.Zip_Code copyWithZone:zone];
        instance.Company_Icon = [self.Company_Icon copyWithZone:zone];
        instance.Company_Logo = [self.Company_Logo copyWithZone:zone];
        instance.User_PWD = [self.User_PWD copyWithZone:zone];
        instance.Company_Name = [self.Company_Name copyWithZone:zone];
        instance.User_Name = [self.User_Name copyWithZone:zone];
        instance.Link_Man = [self.Link_Man copyWithZone:zone];
        instance.Mob_No = [self.Mob_No copyWithZone:zone];
        instance.amount_digit = [self.amount_digit copyWithZone:zone];
        instance.dec_digit = [self.dec_digit copyWithZone:zone];
        instance.exchange_rage_digit = [self.exchange_rage_digit copyWithZone:zone];
        instance.exchange_rate = [self.exchange_rate copyWithZone:zone];
        instance.price_digit = [self.price_digit copyWithZone:zone];
        instance.currency_id = [self.currency_id copyWithZone:zone];
        instance.currency_name = [self.currency_name copyWithZone:zone];
        instance.suffix_currency = [self.suffix_currency copyWithZone:zone];
        instance.SysCurrency = [self.SysCurrency copyWithZone:zone];
        instance.AppBanner = [self.AppBanner copyWithZone:zone];
        instance.useIPText = [self.useIPText copyWithZone:zone];
        instance.keyid = [self.keyid copyWithZone:zone];
        instance.isUseIP = self.isUseIP;
    
    }
    return instance;
}

+(instancetype)UserInfoModelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithdic:dic];
}
-(instancetype)initWithdic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
@end
