//
//  NSString+DXDAString.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/8/26.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSString+DXDAString.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Reachability.h"

@implementation NSString (DXDAString)

//MARK: 图文档
+ (NSString *)accessoryType:(NSString *)orderType
{
    NSString *accessoryType = @"";
    if ([orderType isEqualToString:OrderType_CustOrder]) {
        accessoryType = AccessoryType_CustOrder;
    }
    else if ([orderType isEqualToString:OrderType_Shipper])
    {
        accessoryType = AccessoryType_CustOrder;
    }
    else if ([orderType isEqualToString:OrderType_PurchaseOrder])
    {
        accessoryType = AccessoryType_PurchaseOrder;
    }
    else if ([orderType isEqualToString:OrderType_PurReceipt])
    {
        accessoryType = AccessoryType_PurReceipt;
    }
    else if ([orderType isEqualToString:OrderType_CustomerFollow])
    {
        accessoryType = AccessoryType_CustomerFollow;
    }
    else if ([orderType isEqualToString:OrderType_CustomerFollow])
    {
        accessoryType = AccessoryType_CustomerFollow;
    }
    else if ([orderType isEqualToString:OrderType_Invoice])
    {
        accessoryType = AccessoryType_Invoic;
    }
    else if ([orderType isEqualToString:OrderType_PurInvoice])
    {
        accessoryType = AccessoryType_PurInvoic;
    }
    else if ([orderType isEqualToString:OrderType_VisitSum])
    {
        accessoryType = OrderType_VisitSum;
    }
    else if([orderType isEqualToString:OrderType_Payment])
    {
        accessoryType = AccessoryType_Payment;
    }
    else if([orderType isEqualToString:OrderType_Cash])
    {
        accessoryType = AccessoryType_Cash;
    }
    else if([orderType isEqualToString:OrderType_PGD])
    {
        accessoryType = OrderType_PGD;
    }
    else if([orderType isEqualToString:OrderType_WoReceipt])
    {
        accessoryType = AccessoryType_WoReceipt;
    }
    else if([orderType isEqualToString:OrderType_Issue])
    {
        accessoryType = AccessoryType_Issue;
    }
    else if([orderType isEqualToString:OrderType_WorkOrder])
    {
        accessoryType = AccessoryType_WorkOrder;
    }
    else if([orderType isEqualToString:OrderType_PoReturn])
    {
        accessoryType = AccessoryType_PoReturn;
    }
    else if([orderType isEqualToString:OrderType_CoReturn])
    {
        accessoryType = AccessoryType_CoReturn;
    }
    else if ([orderType isEqualToString:OrderType_CustCharge])
    {
        accessoryType = AccessoryType_CustCharge;
    }
    else if([orderType isEqualToString:OrderType_Quote])
    {
        accessoryType = AccessoryType_Quote;
    }
    else if([orderType isEqualToString:OrderType_PurQuote])
    {
        accessoryType = AccessoryType_PurQuote; 
    }
    else if([orderType isEqualToString:OrderType_WorkPlan])
    {
        accessoryType = AccessoryType_WorkPlan;
    }
    else if([orderType isEqualToString:OrderType_ActReceivable])
    {
        accessoryType = AccessoryType_ActReceivable;
    }
    else if ([orderType isEqualToString:OrderType_ActPayable])
    {
        accessoryType = AccessoryType_ActPayable;
    }
    else if ([orderType isEqualToString:OrderType_Payout])
    {
        accessoryType = AccessoryType_PAYOUT;
    }
    else if ([orderType isEqualToString:OrderType_Requisition]){
        accessoryType = AccessoryType_REQUIS;
    }
    else if([orderType isEqualToString:OrderType_InvQr]){
        accessoryType = AccessoryType_QR;
    }
    else if ([orderType isEqualToString:OrderType_InvQc]){
        accessoryType = AccessoryType_QC;
    }
    else if ([orderType isEqualToString:OrderType_PurInquiry]){
        accessoryType = AccessoryType_PUR_INQ;
    }
    else if ([orderType isEqualToString:OrderType_PurQuote]){
        accessoryType = AccessoryType_PurQuote;
    }
    else if([orderType isEqualToString:@"物料维护"])
    {
        accessoryType = @"Part";
    }
    else if([orderType isEqualToString:@"EqmCheckRecord"])
    {
        accessoryType = @"CHECK_RECO";
    }
    else if ([orderType isEqualToString:@"EqmCheckPlan"])
    {
        accessoryType = @"CHECK_PLAN";
    }
    else if ([orderType isEqualToString:@"EqmEntRepairRecord"])
    {
        accessoryType = @"ENT_RECO";
    }
    else if ([orderType isEqualToString:@"EqmRepairRecord"])
    {
        accessoryType = @"REP_RECO";
    }
    else if ([orderType isEqualToString:@"CallRepairRecord"])
    {
        accessoryType = @"CALL_RECO";
    }
    else if ([orderType isEqualToString:@"MaintainRecord"])
    {
        accessoryType = @"MA_RECO";
    }
    else if ([orderType isEqualToString:@"MaintainPlan"])
    {
        accessoryType = @"MA_PLAN";
    }
    else if ([orderType isEqualToString:@"EquipmentRecord"])
    {
        accessoryType = @"EQM_RECO";
    }
    
    else
    {
        accessoryType = @"";
    }
    return accessoryType;
}

//MARK: 图文档消息转换 采购 -》 销售
+ (NSString *)noticeAccessoryType:(NSString *)orderType
{
    NSString *accessoryType = @"";
    if ([orderType isEqualToString:OrderType_PurchaseOrder]) {//采购单
        accessoryType = AccessoryType_CustOrder;//销售代号
    }else if([orderType isEqualToString:OrderType_PurInquiry]){//采购询价
        accessoryType = AccessoryType_Quote;//销售报价
    }
    return accessoryType;
}


+ (NSString *)baseURL:(NSString *)url action:(NSString *)action
{
    return [NSString stringWithFormat:@"%@%@",url,action];
}

//获取联网方式
+ (NSString *)networkType
{
    NSString *netconnType = @"";
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            
            netconnType = @"no network";
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = @"Wifi";
        }
            break;
            
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netconnType = @"GPRS";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netconnType = @"2.75G EDGE";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netconnType = @"3.5G HSDPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netconnType = @"3.5G HSUPA";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netconnType = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netconnType = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netconnType = @"HRPD";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                netconnType = @"4G";
            }
        }
            break;
            
        default:
            break;
    }
    
    return netconnType;
    
}


//获取运营商信息
+(NSString *)getCarrierName
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry = [carrier carrierName];
    return currentCountry;
}

@end
