//
//  NSObject+BoolType.m
//  x_App
//
//  Created by DXDA on 2017/5/25.
//  Copyright © 2017年 SimpleTable. All rights reserved.
//

#import "NSObject+BoolType.h"
#import "DXDANewsDetailModel.h"
#import "DXDANewsDetailHeadModel.h"

@implementation NSObject (BoolType)

//MARK: - 判断消息 创建模型 纯消息类展示 单据类展示
+(BOOL)judgeModelType:(DXDANewsDetailModel *)model {
    //MARK: - 销售
    if ([model.FromOrderType isEqualToString:OrderType_CustOrder]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ShipperNotice]) {
        return NO;
    }
    //MARK: - 采购
    else if ([model.FromOrderType isEqualToString:OrderType_PurchaseOrder]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ReceNotice]) {
        return NO;
    }
    //MARK: - 应收/应付
    else if ([model.FromOrderType isEqualToString:OrderType_ActReceivable]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActPayable]) {
        return NO;
    }
    //MARK: - 收/付款
    else if ([model.FromOrderType isEqualToString:OrderType_Cash]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Payment]) {
        return NO;
    }
    //MARK: - 销售/采购 发票单
    else if ([model.FromOrderType isEqualToString:OrderType_Invoice]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurInvoice]) {
        return NO;
    }
    //MARK: - 销售/采购 报价单
    else if ([model.FromOrderType isEqualToString:OrderType_Quote]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurQuote]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurInquiry]) {
        return NO;
    }
    //MARK: - 销售/采购 物流单
    else if ([model.FromOrderType isEqualToString:OrderType_Logistics]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogistics]) {
        return NO;
    }
    //MARK: - 销售/采购 物流通知单
    else if ([model.FromOrderType isEqualToString:OrderType_LogisticsNotice]) {
        return NO;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogisticsNotice]) {
        return NO;
    }
    
    return YES;
}


//MARK: - 判断 收付款类型
+(BOOL)judgePaymentModel:(DXDANewsDetailModel *)model {
    if ([model.FromOrderType isEqualToString:OrderType_Cash]) {
        return YES;
    }else if ([model.FromOrderType isEqualToString:OrderType_Payment]) {
        return YES;
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        return YES;
    }else if ([model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        return YES;
    }
    return NO;
}

//MARK: - 判断 收发货类型
+(BOOL)judgeConsigneeModel:(DXDANewsDetailModel *)model {
    if ([model.FromOrderType isEqualToString:OrderType_Shipper] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment]) ) {
        return YES;
    }else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment]) ) {
        return YES;
    }
    return NO;
}

//MARK: - 判断开放的类型
+(BOOL)judgeOrderType:(DXDANewsDetailModel *)model {
    if ([model.FromOrderType isEqualToString:OrderType_ActPayable]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActReceivable]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Cash]) {
        return YES;
    }else if ([model.FromOrderType isEqualToString:OrderType_Payment]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_CustOrder]) {
        return YES;
    }else if ([model.FromOrderType isEqualToString:OrderType_PurchaseOrder]) {
        return YES;
    }
    return NO;
}

//MARK: - 判断 是否显示总金额 (销售、采购 物流单 、物流通知单 默认隐藏)
+(BOOL)judgeAmountHidden:(DXDANewsDetailModel *)model {
    if ([model.FromOrderType isEqualToString:OrderType_Logistics]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogistics]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_LogisticsNotice]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogisticsNotice]) {
        return YES;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurInquiry]){
        return YES;
    }
    return NO;
}


//MARK: - 返回 push 类型
+(NSString *)returnPushType:(DXDANewsDetailModel *)model {
 
    if ([model.FromOrderType isEqualToString:@""]) {
        return @"";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_CustOrder] && ([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        return @"order_pay";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_CustOrder]) {
        return OrderType_CustOrder;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurchaseOrder] && ([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        return @"order_pay";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurchaseOrder]) {
        return OrderType_CustOrder;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper] && ([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        return @"order_pay";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper]) {
        return OrderType_Shipper;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt] && ([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        return @"order_pay";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt]) {
        return OrderType_Shipper;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Cash] && ![model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        if (model.head.count > 0) {
            DXDANewsDetailHeadModel *headModel = model.head[0];
            if ([headModel.cash_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
            else if ([headModel.payment_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
        }
        return OrderType_Cash;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Payment] && ![model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        if (model.head.count > 0) {
            DXDANewsDetailHeadModel *headModel = model.head[0];
            if ([headModel.cash_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
            else if ([headModel.payment_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
        }
        return OrderType_Cash;
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        if (model.head.count > 0) {
            DXDANewsDetailHeadModel *headModel = model.head[0];
            if ([headModel.cash_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
            else if ([headModel.payment_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
        }
        return OrderType_Cash;
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        if (model.head.count > 0) {
            DXDANewsDetailHeadModel *headModel = model.head[0];
            if ([headModel.cash_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
            else if ([headModel.payment_type isEqualToString:@"P"]) {
                return @"order_pay";
            }
        }
        return OrderType_Cash;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActPayable]) {
        return OrderType_ActReceivable;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActReceivable]) {
        return OrderType_ActReceivable;
    }
    // 报价单
    else if ([model.FromOrderType isEqualToString:OrderType_Quote]) {
        return OrderType_Quote;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurQuote]) {
        return OrderType_Quote;
    }
    //采购询价
    else if([model.FromOrderType isEqualToString:OrderType_PurInquiry]){
        return OrderType_Quote;
    }
    // 发票单
    else if ([model.FromOrderType isEqualToString:OrderType_Invoice]) {
        return OrderType_Invoice;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurInvoice]) {
        return OrderType_Invoice;
    }
    // 物流单
    else if ([model.FromOrderType isEqualToString:OrderType_Logistics]) {
        return OrderType_Logistics;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogistics]) {
        return OrderType_Logistics;
    }
    // 物流通知单
    else if ([model.FromOrderType isEqualToString:OrderType_LogisticsNotice]) {
        return OrderType_LogisticsNotice;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogisticsNotice]) {
        return OrderType_LogisticsNotice;
    }
    // 收发货通知单
    else if ([model.FromOrderType isEqualToString:OrderType_ShipperNotice]) {
        return OrderType_ShipperNotice;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ReceNotice]) {
        return OrderType_ShipperNotice;
    }
    //退货单
    else if ([model.FromOrderType isEqualToString:OrderType_CoReturn]) {
        return OrderType_CoReturn;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PoReturn]) {
        return OrderType_CoReturn;
    }
    //生产领料单、 生产入库单、其他出、入库 详情
    else if ([model.FromOrderType isEqualToString:OrderType_InvQr]){
        return OrderType_InvQr;
    }else if ([model.FromOrderType isEqualToString:OrderType_InvQc]){
        return OrderType_InvQr;
    }else if ([model.FromOrderType isEqualToString:OrderType_WoReceipt]){
        return OrderType_InvQr;
    }else if ([model.FromOrderType isEqualToString:OrderType_Issue]){
        return OrderType_InvQr;
    }
    //盘盈、盘亏单 详情
    else if ([model.FromOrderType isEqualToString:OrderType_InvPk]){
        return OrderType_InvPk;
    }else if ([model.FromOrderType isEqualToString:OrderType_InvPy]){
        return OrderType_InvPk;
    }
    //工票
    else if ([model.FromOrderType isEqualToString:OrderType_TICKET]){
        return OrderType_TICKET;
    }
    //派工单
    else if ([model.FromOrderType isEqualToString:OrderType_PGD]){
        return OrderType_PGD;
    }
    //费用申请单
    else if ([model.FromOrderType isEqualToString:OrderType_CustCharge]){
        return OrderType_CustCharge;
    }
    //其他收付款单
    else if ([model.FromOrderType isEqualToString:OrderType_Payout]){
        return OrderType_Payout;
    }
    //请购单
    else if ([model.FromOrderType isEqualToString:OrderType_Requisition]){
        return OrderType_Requisition;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_WorkOrder]){
        return OrderType_WorkOrder;
    }
    //维修记录来自报修记录消息
    else if([model.FromOrderType isEqualToString:OrderType_CallRepairRecord]){
        
        return OrderType_CallRepairRecord;
    }
    else if([model.FromOrderType isEqualToString:YCJType_MaintainPlan]){
        return YCJType_MaintainPlan;
    }
    
    // 任务
    else if ([model.FromOrderType isEqualToString:OrderType_WorkTask]) {
        return OrderType_WorkTask;
    }
    return @"";
}

#pragma mark - 返回真正fromOrderType
+(NSString *)returnTrueOrderType:(DXDANewsDetailModel *)model {
    if ([model.FromOrderType isEqualToString:OrderType_Cash] && [model.MyFinalOrderType isEqualToString:@""]) {
        return OrderType_Cash;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Payment] && [model.MyFinalOrderType isEqualToString:@""]) {
        return OrderType_Payment;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_CustOrder] && [model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        return OrderType_Cash;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_CustOrder] && [model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        return OrderType_Payment;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper] && [model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        return OrderType_Cash;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper] && [model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        return OrderType_Payment;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt] && [model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        return OrderType_Cash;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt] && [model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        return OrderType_Payment;
    }
    
    
    return model.MyFinalOrderType;
}

#pragma mark - 消息类型 - title New
+(NSString *)returnOrderTitleName:(DXDANewsDetailModel *)model {
    
    UserInfoModel *userModel = [UserInfoManager sharedUserInfoManager].readUserdata;
    
    if ([model.FromOrderType isEqualToString:OrderType_CustOrder] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        return @"订单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurchaseOrder] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        return @"订单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"发货消息";
        }
        return @"收货消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"收货消息";
        }
        return @"发货消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Cash]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"收款消息";
        }
        return @"付款消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Payment]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"付款消息";
        }
        return @"收款消息";
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        return @"收款消息";
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        return @"付款消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActPayable]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"应付单消息";
        }
        return @"应收单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActReceivable]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"应收单消息";
        }
        return @"应付单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurInquiry]) {
        return @"采购询价单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Quote]) {
        return @"销售报价单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurQuote]) {
        return @"采购报价单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Invoice]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"销售发票单消息";
        }
        return @"采购发票单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurInvoice]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"采购发票单消息";
        }
        return @"销售发票单消息";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_LogisticsNotice]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"销售物流通知单";
        }
        return @"采购物流通知单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogisticsNotice]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"采购物流通知单";
        }
        return @"销售物流通知单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Logistics]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"销售物流单";
        }
        return @"采购物流单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurLogistics]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"采购物流单";
        }
        return @"销售物流单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ShipperNotice]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"发货通知单";
        }
        return @"收货通知单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ReceNotice]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"收货通知单";
        }
        return @"发货通知单";
    }
    //费用申请单
    else if([model.FromOrderType isEqualToString:OrderType_CustCharge]){
        return @"费用申请单消息";
    }
    //其他收付款单
    else if([model.FromOrderType isEqualToString:OrderType_Payout]){
        return @"其他收付款消息";
    }
    //销售退货
    else if([model.FromOrderType isEqualToString:OrderType_CoReturn]){
        return @"销售退货消息";
    }
    //采购退货
    else if([model.FromOrderType isEqualToString:OrderType_PoReturn]){
        return @"采购退货消息";
    }
    //工票单
    else if([model.FromOrderType isEqualToString:OrderType_TICKET]){
        return @"工票单消息";
    }
    //派工单
    else if([model.FromOrderType isEqualToString:OrderType_PGD]){
        return @"派工单消息";
    }
    //盘盈单
    else if([model.FromOrderType isEqualToString:OrderType_InvPy]){
        return @"盘盈单消息";
    }
    //盘亏单
    else if([model.FromOrderType isEqualToString:OrderType_InvPk]){
        return @"盘亏单消息";
    }
    //生产入库单
    else if([model.FromOrderType isEqualToString:OrderType_WoReceipt]){
        return @"生产入库单消息";
    }
    //其他入库单
    else if([model.FromOrderType isEqualToString:OrderType_InvQr]){
        return @"其他入库单消息";
    }
    //其他出库单
    else if([model.FromOrderType isEqualToString:OrderType_InvQc]){
        return @"其他出库单消息";
    }
    //生产领料
    else if([model.FromOrderType isEqualToString:OrderType_Issue]){
        return @"生产领料单消息";
    }
    //请购单
    else if ([model.FromOrderType isEqualToString:OrderType_Requisition]){
        return @"请购单消息";
    }
    //生产单
    else if([model.FromOrderType isEqualToString:OrderType_WorkOrder]){
        return @"生产单消息";
    }
    

    
    
    return @"";
}

// ccz 修改
#pragma mark - 详情 title New
+(NSString *)returnControllerTitleName:(DXDANewsDetailModel *)model
{
    UserInfoModel *userModel = [UserInfoManager sharedUserInfoManager].readUserdata;
    
    if ([model.FromOrderType isEqualToString:OrderType_CustOrder] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"采购订单";
        }
        return @"销售订单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurchaseOrder] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"销售订单";
        }
        return @"采购订单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Shipper] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"收货单";
        }
        return @"发货单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_PurReceipt] && !([model.MyFinalOrderType isEqualToString:OrderType_Cash] || [model.MyFinalOrderType isEqualToString:OrderType_Payment])) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"发货单";
        }
        return @"收货单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Cash]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"付款单详情";
        }
        return @"收款单详情";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Payment]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"收款单详情";
        }
        return @"付款单详情";
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"付款单详情";
        }
        return @"收款单详情";
    }
    else if ([model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"收款单详情";
        }
        return @"付款单详情";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActPayable]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"应付单";
        }
        return @"应收单";
    }
    else if ([model.FromOrderType isEqualToString:OrderType_ActReceivable]) {
        if ([model.SendPlatform isEqualToString:userModel.User_ID]) {
            return @"应收单";
        }
        return @"应付单";
    }
    return @"";
}

#pragma mark - 返回 收付款 预收预付款 cash_type payment_type 类型
+(NSString *)returnCash_payment_type:(DXDANewsDetailModel *)model {
    
    if (model.head.count == 0) {
        return @"";
    }
    DXDANewsDetailHeadModel *headModel = model.head[0];
    if ([model.FromOrderType isEqualToString:OrderType_Cash]) {
        return headModel.cash_type;
    }
    else if ([model.FromOrderType isEqualToString:OrderType_Payment]) {
        return headModel.payment_type;
    }
//    if ([model.FromOrderType isEqualToString:OrderType_Cash] && [model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
//        return headModel.cash_type;
//    }
//    else if ([model.FromOrderType isEqualToString:OrderType_Cash] && [model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
//        return headModel.payment_type;
//    }
//    else if ([model.FromOrderType isEqualToString:OrderType_Payment] && [model.MyFinalOrderType isEqualToString:OrderType_Payment]) {
//        return headModel.payment_type;
//    }
//    else if ([model.FromOrderType isEqualToString:OrderType_Payment] && [model.MyFinalOrderType isEqualToString:OrderType_Cash]) {
//        return headModel.cash_type;
//    }
    
    return @"";
}


#pragma mark - 根据bill_status 状态返回消息当前状态
+(NSString *)returnCurrentStatus:(NSInteger)status {
    NSString *tempStr;
    switch (status) {
        case 1:
            tempStr = @"未查看";
            break;
        case 2:
            tempStr = @"已接单" ;
            break;
        case 3:
            tempStr = @"已查看未处理" ;
            break;
        case 4:
            tempStr = @"确认修改" ;
            break;
        case 5:
            tempStr = @"修改中" ;
            break;
        case 6:
            tempStr = @"拒单" ;
            break;
        case 7:
            tempStr = @"等待对方确认修改" ;
            break;
        case 9:
            tempStr = @"已查看" ;
            break;
        case 10:
            tempStr = @"已确认" ;
            break;
        case 11:
            tempStr = @"已作废" ;
            break;
        case 12:
            tempStr = @"已检查" ;
            break;
        case 13:
            tempStr = @"已拒绝" ;
            break;
        case 15:
            tempStr = @"已处理" ;
            break;
        // CRM 任务状态
        case 16:
            tempStr = @"已完成" ;
            break;
        case 17:
            tempStr = @"已取消" ;
            break;
        case 18:
            tempStr = @"已拒绝" ;
            break;
        case 19:
            tempStr = @"已关闭" ;
            break;
        case 26:
            tempStr = @"已审批" ;
            break;
        case 27:
            tempStr = @"已反审批" ;
            break;
        case 28:
            tempStr = @"已退回" ;
            break;
        case 29:
            tempStr = @"已作废" ;
            break;
        case 31:
            tempStr = @"已删除" ;
            break;
            
        default:
            break;
    }
    return tempStr;
}

@end
