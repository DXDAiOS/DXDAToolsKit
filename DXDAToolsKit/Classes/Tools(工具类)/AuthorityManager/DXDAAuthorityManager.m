//
//  DXDAAuthorityManager.m
//  x_App
//
//  Created by DXDA on 2017/6/13.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import "DXDAAuthorityManager.h"
#import "DXDAAuthorityModel.h"
#import "DXDADefaultTimeManager.h"

@implementation DXDAAuthorityManager

#pragma mark - 判断是否有权限
+ (void)judgeAuthorityType:(AuthorityType)type
             authority_id:(NSString *)authority_id
              defaultOpen:(BOOL)open
                  success:(void(^)(BOOL flag))success
                     fail:(void(^)(NSString *message))fail
                    error:(void(^)(NSString *message))errorBlock {
    
    //MARK: - 临时控制
    if (
        [authority_id isEqualToString:@"库存查询"]||
        [authority_id isEqualToString:@"同事交流"]||
        [authority_id isEqualToString:@"客户标签"]||
        [authority_id isEqualToString:@"同事聊天"]
        ) {
        open = YES;
    }
    // 测试环境默认开启权限 （测试环境权限判断异常）
//    if([AppType isEqualToString:@"IosMSCApp_Beta"])
//    {
//        open = YES;
//    }
    if (open) {
        success ? success(YES) : nil;
        return;
    }
    
    [DXDADefaultTimeManager reloadAuthorityPower];

    if (authority_id.integerValue == 0) {
        authority_id = [DXDAAuthorityManager returnCurrentAuthority_id:authority_id];
    }

    if (!authority_id) {
        NSLog(@"没有此id");
        fail ? fail(@"暂不支持此功能") : nil;
        return;
    }
    
    // 默认请求权限
    [DXDAAuthorityManager requestAuthority:type authority_id:authority_id completion:^(BOOL flag) {
        if (flag) {
            success ? success(flag) : nil;
            return ;
        }
        fail ? fail(NoPower) : nil;
        
    } error:^(NSString *error) {
        errorBlock ? errorBlock(error) : nil;
    }];
    return ;
/*
    默认取本地权限 若没有则请求权限
    if (![[NSUserDefaults standardUserDefaults] objectForKey:authority_id] || ![[[NSUserDefaults standardUserDefaults] objectForKey:authority_id] isKindOfClass:[NSData class]]) {
        [DXDAAuthorityManager requestAuthority:type authority_id:authority_id completion:^(BOOL flag) {
            if (flag) {
                success ? success(flag) : nil;
                return ;
            }
            fail ? fail(NoPower) : nil;
            
        } error:^(NSString *error) {
            errorBlock ? errorBlock(error) : nil;
        }];
        return ;
    }
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:authority_id];
    
    if (!data) {
        NSLog(@"解析错误");
        fail ? fail(@"解析错误") : nil;
        return;
    }
    
    NSArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (tempArray.count == 0) {
        fail ? fail(NoPower) : nil;
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:authority_id];
        return;
    }
    NSString *powerType = [DXDAAuthorityManager returnCurrentPower_id:type];
    
    BOOL isFail = NO;
    
    for (DXDAAuthorityModel *model in tempArray) {
        if ([model.Power_ID isEqualToString:powerType]) {
            if (model.Valid_Flag.boolValue) {
                success ? success(model.Valid_Flag.boolValue) : nil;
                isFail = NO;
            }
            else {
                fail ? fail(NoPower) : nil;
                isFail = NO;
            }
            break;
        }
        else {
            isFail = YES;
        }
    }
    if (isFail) {
        fail ? fail(NoPower) : nil;
    }
 */
}

#pragma mark - 请求权限
+ (void)requestAuthority:(AuthorityType)type authority_id:(NSString *)authority_id completion:(void(^)(BOOL flag))completion error:(void(^)(NSString *error))errorBlock {

    UserInfoModel *userModel = [[UserInfoManager sharedUserInfoManager] readUserdata];
    
    NSDictionary *dic = @{@"userID":userModel.strUserID,
                          @"userPWD":userModel.strUserPWD,
                          @"moduleId":authority_id,
                          @"url":@""
                          };
    
    [DXDAAFNetworkManager postWithURLString:StrWithFormat(C_W_UrlServer,Rxdx_SelectFunModule) parameters:dic success:^(id responseObject) {

        NSDictionary *dicResComm = responseObject[@"ResComm"] ? : responseObject;
        
        if ([dicResComm[@"ResState"] integerValue] != 0) {
            errorBlock ? errorBlock(NoPower) : nil;
            return ;
        }
        
        if (![responseObject[@"DataList"] isKindOfClass:[NSArray class]]) {
            errorBlock ? errorBlock(NoPower) : nil;
            return;
        }
        NSArray *tempArray = [DXDAAuthorityModel createWith:responseObject[@"DataList"]];
        if (tempArray.count == 0) {
            errorBlock ? errorBlock(NoPower) : nil;
            return;
        }
        NSData * data  = [NSKeyedArchiver archivedDataWithRootObject:tempArray];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:authority_id];

        NSString *powerType = [DXDAAuthorityManager returnCurrentPower_id:type];
        
        BOOL isFail = NO;
        for (DXDAAuthorityModel *model in tempArray) {
            if ([model.Power_ID isEqualToString:powerType]) {
                if (model.Valid_Flag.boolValue) {
                    completion ? completion(model.Valid_Flag.boolValue) : nil;
                    isFail = NO;
                }
                else {
                    errorBlock ? errorBlock(NoPower) : nil;
                    isFail = NO;
                }
                break;
            }
            else {
                isFail = YES;;
            }
        }
        if (isFail) {
            errorBlock ? errorBlock(NoPower) : nil;
        }
        
    } failure:^(NSString *error) {
        errorBlock ? errorBlock(error) : nil;
    }];
}

#pragma mark - 清空所有权限
+ (void)clearAuthorityData {
    NSArray *authorityArray = @[/* ↓ 单据ID */
                                Authority_CustOrder,
                                Authority_Shipper,
                                Authority_PurchaseOrder,
                                Authority_PurReceipt,// = @"0107";     //采购收货
                                Authority_ReceNotice,// = @"0111";   // 收货通知单
                                Authority_PurReceipt,
                                Authority_WoReceipt,
                                Authority_Cash,
                                Authority_Payment,
                                Authority_ActReceivable,
                                Authority_ActPayable,
                                Authority_InvQr,
                                Authority_InvQc,
                                Authority_Profit,
                                Authority_Loss,
                                Authority_SalesReport,
                                Authority_BusinessConnection,
                                Authority_ExpenseList,
                                Authority_CustomerContact,
                                Authority_BuyingRequisition,
                                Authority_Ticket,
                                Authority_Quote,
                                Authority_Invoice,
                                Authority_PurInvoice,
                                Authority_ShipperNotice,
                                Authority_ReceNotice,
                                Authority_PurLogisticsNotice,
                                Authority_PurLogistics,
                                Authority_LogisticsNotice,
                                Authority_Logistics,

                                
                                Authority_Progress,// = @"0639";   // 进度状态
                                Authority_BI,// = @"0801001";   // BI报表
                                /* ↓ 客户、供应商资料ID */
                                Authority_Customer_infos,
                                Authority_Vendor_infos,
                                /* ↓ 报表 */
                                Authority_M0801003,
                                Authority_BI,
                                /* ↓ 基础数据ID */
                                Authority_Material_maintain,
                                Authority_Material_category,
                                Authority_Unit,
                                Authority_Material_warehouse,
                                Authority_Customer_category,
                                Authority_Vendor_category,
                                Authority_Company_infos,
                                Authority_Address_maintain,
                                Authority_Emploryee_infos,
                                Authority_Department_infos,
                                Authority_Tax_infos,
                                Authority_Address_infos,
                                Authority_ExpenseProject,
                                Authority_Progress,
                                /* ↓ 我的模块 */
                                Authority_InviteRegister,// = @"0904";        // 邀请注册
                                Authority_SendMessage,// = @"0911";        // 发送消息
                                Authority_AboutUs,// = @"0914";        // 关于我们
                                Authority_BankCard,// = @"0916";        // 银行卡管理
                                Authority_CompanyAuthentication,// = @"0917";        // 企业认证
                                /* ↓ CRM */
                                Authority_CRM,// = @"0687";            // 销售线索
                                Authority_SaleCue,// = @"0641";        // 销售线索
                                Authority_clew,// = @"0642";           // 线索池
                                Authority_highSeas,// = @"0643";       // 公海
                                Authority_EmpOutRec,// = @"0646";      // 外勤
                                Authority_VisitPlan,// = @"0647";      // 拜访计划
                                Authority_VisitSum,// = @"0648";       // 拜访总结
                                Authority_Business,// = @"0649";       // 商机
                                Authority_CustStage,// = @"0650";      // 销售流程
                                Authority_Opportunity,// = @"0653";      // 商机报表
                                Authority_UpSelfGoods,// = @"0619";   // 上架商品
                                Authority_VisitType,// = @"0658";      // 拜访类型
                                Authority_AskVacation, // 请假单
                                Authority_Task, // 任务
                                Authority_BusinessTrend,//商机趋势
                                ];
    
    for (int i=0; i<authorityArray.count; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:authorityArray[i]];
    }
}

#pragma mark - 返回当前权限类型
+ (NSString *)returnCurrentPower_id:(AuthorityType)type {
    switch (type) {
        case authorityAddType:
            return PowerID_Add;
            break;
        case authorityDeleteType:
            return PowerID_Delete;
            break;
        case authorityUpdateType:
            return PowerID_Update;
            break;
        case authoritySelectType:
            return PowerID_Select;
            break;
        case authorityApproveType:
            return PowerID_Appr;
            break;
        case authorityDisApproveType:
            return PowerID_Anti;
            break;
        case authorityNextstep:
            return PowerID_Nextstep;
            break;
        case authorityPrint:
            return PowerID_Print;
            break;
        default:
            break;
    }
    return nil;
}

+ (NSString *)returnCurrentAuthority_id:(NSString *)classTitle {
    if ([classTitle isEqualToString:@"采购订单"]) {
        return Authority_PurchaseOrder;
    }
    else if ([classTitle isEqualToString:@"采购收货"]) {
        return Authority_PurReceipt;
    }
    else if ([classTitle isEqualToString:@"生产入库单"]) {
        return Authority_WoReceipt;
    }
    else if ([classTitle isEqualToString:@"生产领料单"]){
        return Authority_Issue;
    }
    else if ([classTitle isEqualToString:@"业务联络单"]) {
        return Authority_BusinessConnection;
    }
    else if ([classTitle isEqualToString:@"订单录入"]) {
        return Authority_CustOrder;
    }
    else if ([classTitle isEqualToString:@"销售发货"]) {
        return Authority_Shipper;
    }
    else if ([classTitle isEqualToString:@"应付账单"]) {
        return Authority_ActPayable;
    }
    else if ([classTitle isEqualToString:@"应收账单"]) {
        return Authority_ActReceivable;
    }
    else if ([classTitle isEqualToString:@"收款单"]) {
        return Authority_Cash;
    }
    else if ([classTitle isEqualToString:@"预收款单"]) {
        return Authority_Cash;
    }
    else if ([classTitle isEqualToString:@"付款单"]) {
        return Authority_Payment;
    }
    else if ([classTitle isEqualToString:@"预付款单"]) {
        return Authority_Payment;
    }
    else if ([classTitle isEqualToString:@"其他入库单"]) {
        return Authority_InvQr;
    }
    else if ([classTitle isEqualToString:@"其他出库单"]) {
        return Authority_InvQc;
    }
    else if([classTitle isEqualToString:@"其他收付款单"]){
        return Authority_Payout;
    }
    else if ([classTitle isEqualToString:@"盘盈单"]) {
        return Authority_Profit;
    }
    else if ([classTitle isEqualToString:@"盘亏单"]) {
        return Authority_Loss;
    }
    else if ([classTitle isEqualToString:@"客户资料"] || [classTitle isEqualToString:@"客户"]) {
        return Authority_Customer_infos;
    }
    else if ([classTitle isEqualToString:@"供应商资料"]) {
        return Authority_Vendor_infos;
    }
    else if ([classTitle isEqualToString:@"费用申请单"]) {
        return Authority_ExpenseList;
    }
    else if ([classTitle isEqualToString:@"客户联络单"]) {
        return Authority_CustomerContact;
    }
    else if ([classTitle isEqualToString:@"请购单"]) {
        return Authority_BuyingRequisition;
    }
    else if ([classTitle isEqualToString:@"工票单"]) {
        return Authority_Ticket;
    }
    else if ([classTitle isEqualToString:@"派工单"]) {
        return Authority_PGD;
    }
    else if ([classTitle isEqualToString:@"销售报价"]) {
        return Authority_Quote;
    }
    else if ([classTitle isEqualToString:@"采购报价"]) {
        return Authority_PurQuote;
    }
    else if ([classTitle isEqualToString:@"采购询价"]) {
        return Authority_PurQuote;
    }
    else if ([classTitle isEqualToString:@"销售发票"]) {
        return Authority_Invoice;
    }
    else if ([classTitle isEqualToString:@"采购发票"]) {
        return Authority_PurInvoice;
    }
    else if ([classTitle isEqualToString:@"销售物流通知单"]) {
        return Authority_LogisticsNotice;
    }
    else if([classTitle isEqualToString:@"销售退货单"]){
        return Authority_CoReturn;
    }
    else if ([classTitle isEqualToString:@"采购物流通知单"]) {
        return Authority_PurLogisticsNotice;
    }
    else if ([classTitle isEqualToString:@"销售物流单"]) {
        return Authority_Logistics;
    }
    else if ([classTitle isEqualToString:@"采购物流单"]) {
        return Authority_PurLogistics;
    }
    else if ([classTitle isEqualToString:@"收货通知单"]) {
        return Authority_ReceNotice;
    }
    else if ([classTitle isEqualToString:@"发货通知单"]) {
        return Authority_ShipperNotice;
    }
    /* 报表 */
    else if ([classTitle isEqualToString:@"销售报表"]) {
        return Authority_M0801003;
    }
    else if ([classTitle isEqualToString:@"上架商品"]) {
        return Authority_UpSelfGoods;
    }
    /* 基础数据 */
    else if ([classTitle isEqualToString:@"物料维护"]) {
        return Authority_Material_maintain;
    }
    else if ([classTitle isEqualToString:@"员工"]) {
        return Authority_Emploryee_infos;
    }
    else if ([classTitle isEqualToString:@"部门"]) {
        return Authority_Department_infos;
    }
    else if ([classTitle isEqualToString:@"税目明细"]) {
        return Authority_Tax_infos;
    }
    else if ([classTitle isEqualToString:@"收货地址"]) {
        return Authority_Address_infos;
    }
    else if ([classTitle isEqualToString:@"品牌"]) {
        return Authority_Brand_infos;
    }
    else if ([classTitle isEqualToString:@"计量单位"]) {
        return Authority_Unit;
    }
    else if ([classTitle isEqualToString:@"物料类别"]) {
        return Authority_Material_category;
    }
    else if ([classTitle isEqualToString:@"供应商类别"]) {
        return Authority_Vendor_category;
    }
    else if ([classTitle isEqualToString:@"客户类别"]) {
        return Authority_Customer_category;
    }
    else if ([classTitle isEqualToString:@"物料仓库"]) {
        return Authority_Material_warehouse;
    }
    else if ([classTitle isEqualToString:@"费用项目"]) {
        return Authority_ExpenseProject;
    }
    else if ([classTitle isEqualToString:@"进度状态"]) {
        return Authority_Progress;
    }
    else if ([classTitle isEqualToString:@"生产单"]) {
        return Authority_WorkOrder;
    }
    else if ([classTitle isEqualToString:@"采购退货单"]){
        return Authority_PoReturn;
    }
    
    /* 我的模块 */
    else if ([classTitle isEqualToString:@"邀请注册"]) {
        return Authority_InviteRegister;
    }
    else if ([classTitle isEqualToString:@"发送消息"]) {
        return Authority_SendMessage;
    }
    else if ([classTitle isEqualToString:@"关于我们"]) {
        return Authority_AboutUs;
    }
    else if ([classTitle isEqualToString:@"银行卡管理"]) {
        return Authority_BankCard;
    }
    else if ([classTitle isEqualToString:@"企业认证"]) {
        return Authority_CompanyAuthentication;
    }
    
    /* CRM */
    else if ([classTitle isEqualToString:@"CRM"]) {
        return Authority_CRM;
    }
    else if ([classTitle isEqualToString:@"销售线索"]) {
        return Authority_SaleCue;
    }
    else if ([classTitle isEqualToString:@"销售漏斗"]) {
        return Authority_salesFunnel;
    }
    else if ([classTitle isEqualToString:@"销售活动统计"]) {
        return Authority_salesActivities;
    }
    else if ([classTitle isEqualToString:@"KPI报表"]){
        return Authority_Dimension;
    }
    else if ([classTitle isEqualToString:@"AI报表"]){
        return Authority_AIReport;
    }
    else if ([classTitle isEqualToString:@"客户维度报表"]){
        return Authority_CustDimensionReport;
    }
//    else if ([orderType isEqualToString:@"线索池"]) {
//        return OrderType_clew;
//    }
//    else if ([orderType isEqualToString:@"公海"]) {
//        return OrderType_highSeas;
//    }
    else if ([classTitle isEqualToString:@"线索池"]) {
        return Authority_SaleCue;
    }
    else if ([classTitle isEqualToString:@"公海"]) {
        return Authority_Customer_infos;
    }
    else if ([classTitle isEqualToString:@"外勤签到"]) {
        return Authority_EmpOutRec;
    }
    else if ([classTitle isEqualToString:@"外勤跟踪"]) {
        return Authority_EmpOutRec;
    }
    else if ([classTitle isEqualToString:@"外勤审批"]) {
        return Authority_EmpOutRec;
    }
    else if ([classTitle isEqualToString:@"拜访计划"]) {
        return Authority_VisitPlan;
    }
    else if ([classTitle isEqualToString:@"拜访总结"]) {
        return Authority_VisitSum;
    }
    else if ([classTitle isEqualToString:@"商机"]) {
        return Authority_Business;
    }
    else if ([classTitle isEqualToString:@"销售流程"]) {
        return Authority_CustStage;
    }
    else if ([classTitle isEqualToString:@"商机报表"]) {
        return Authority_Opportunity;
    }
    else if ([classTitle isEqualToString:@"商机趋势"]){
        return Authority_BusinessTrend;
    }
    else if ([classTitle isEqualToString:@"拜访类型"]) {
        return Authority_VisitType;
    }
    else if ([classTitle isEqualToString:@"请假单"]) {
        return Authority_AskVacation;
    }
    else if ([classTitle isEqualToString:@"任务"])
    {
        return Authority_Task;
    }
    else if ([classTitle isEqualToString:@"日程"]) {
        return Authority_Schedule;
    }
    else if ([classTitle isEqualToString:@"计划"])
    {
        return Authority_WorkPlan;
    }else if ([classTitle isEqualToString:@"系统日志"]){
        return Authority_SystemLog;
    }else if ([classTitle isEqualToString:@"知识库"]){
        return Authority_BasicData;
    }else if ([classTitle isEqualToString:@"计划工作统计"]){
        return Authority_PlanSumReport;
    }else if ([classTitle isEqualToString:@"SWOT"]){
        return Authority_SWOT;
    }

    /* 消费链 */
    else if ([classTitle isEqualToString:@"按单收款"]) {
        return nil;
    }
    else if ([classTitle isEqualToString:@"收款"]) {
        return nil;
    }
    else if ([classTitle isEqualToString:@"收押金"]) {
        return nil;
    }
    
    return nil;
}

+ (NSString *)returnCurrentClassTitle:(NSString *)orderType {
    if ([orderType isEqualToString:OrderType_PurchaseOrder]) {
        return @"采购订单";
    }
    else if ([orderType isEqualToString:OrderType_PurReceipt]) {
        return @"采购收货";
    }
    else if ([orderType isEqualToString:OrderType_WoReceipt]) {
        return @"生产入库单";
    }
    else if ([orderType isEqualToString:OrderType_Issue]){
        return @"生产领料单";
    }
    else if ([orderType isEqualToString:OrderType_Business]) {
        return @"业务联络单";
    }
    else if ([orderType isEqualToString:OrderType_CustOrder]) {
        return @"订单录入";
    }
    else if ([orderType isEqualToString:OrderType_Shipper]) {
        return @"销售发货";
    }
    else if ([orderType isEqualToString:OrderType_ActPayable]) {
        return @"应付账单";
    }
    else if ([orderType isEqualToString:OrderType_ActReceivable]) {
        return @"应收账单";
    }
    else if ([orderType isEqualToString:OrderType_Cash]) {
        return @"收款单";
    }
    else if ([orderType isEqualToString:OrderType_Cash]) {
        return @"预收款单";
    }
    else if ([orderType isEqualToString:OrderType_Payment]) {
        return @"付款单";
    }
    else if ([orderType isEqualToString:OrderType_Payment]) {
        return @"预付款单";
    }
    else if ([orderType isEqualToString:OrderType_InvQr]) {
        return @"其他入库单";
    }
    else if ([orderType isEqualToString:OrderType_InvQc]) {
        return @"其他出库单";
    }
    else if ([orderType isEqualToString:OrderType_InvPy]) {
        return @"盘盈单";
    }
    else if ([orderType isEqualToString:OrderType_InvPk]) {
        return @"盘亏单";
    }
    else if ([orderType isEqualToString:OrderType_CoReturn]){
        return @"销售退货单";
    }
    else if ([orderType isEqualToString:OrderType_PoReturn]){
        return @"采购退货单";
    }
    
    return @"";
}



@end
