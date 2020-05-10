//
//  DXDAMark.h
//  x_App
//
//  Created by 东信达 on 2017/6/30.
//  Copyright © 2017年 SimpleTable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDAMark : NSObject

#pragma mark -  收付款类型
/// 预收预付
#define Mark_SalesShoppingAdvance @"SalesShoppingAdvance"
/// 按单收付款
#define Mark_ShipmentsOrProceeds @"ShipmentsOrProceeds"
/// 批量结账
#define Mark_BatchCheckout @"BatchCheckout"
/// 直接付款
#define Mark_ProceedsZJ @"ProceedsZJ"
/// 发货单收获单收款
#define Mark_ShipmentsOrPurReceipt @"ShipmentsOrPurReceipt"
/// 销售采购查询收付款
#define Mark_ShipperOrCustOrder @"ShipperOrCustOrder"


#pragma mark -  选择商品支付页
/// 按单发货收款
#define ProceedsVC_Bill @"BillProceedsVC"
/// 销售采购查询
#define ProceedsVC_Sales_Shopping @"SalesShoppingProceedsVC"
/// 发货收货查询
#define ProceedsVC_Shipments_Proceeds @"ShipmentsProceedsBillProceedsVC"



#pragma mark -  PayType
/// 至傅报支付
#define Mark_PAY_TYPE_AS @"AS"
/// 微信支付
#define Mark_PAY_TYPE_WS @"WS"
/// 至傅报支付
#define Mark_PAY_TYPE_AT @"AT"
/// 微信支付
#define Mark_PAY_TYPE_WT @"WT"
/// 银联支付
#define Mark_PAY_TYPE_B @"B"
/// 现金支付
#define Mark_PAY_TYPE_C @"C"
+ (NSString *)PayTypeName:(NSString *)Mark_PAY_TYPE;

#pragma mark -  客户联络单详情类型
/// 进度状态
#define Mark_DetailsType_State @"State"
/// 联系人
#define Mark_DetailsType_Contact @"Contact"

#pragma mark -  上下单
/// 上一单
#define Bill_Previous @"Previous"
/// 下一单
#define Bill_Next @"Next"


@end
