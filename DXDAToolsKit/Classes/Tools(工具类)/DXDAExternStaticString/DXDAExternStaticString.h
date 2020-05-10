//
//  DXDAExternStaticString.h
//  NewApp3.0
//
//  Created by DXDA on 2017/7/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Description SignInDetailMode 签到详情样式
 * SignInDetailMode_check 查看
 * SignInDetailMode_approve 审批
 * SignInDetailMode_notApprove 反审批
 * SignInDetailMode_finish 已完成
 */

typedef NS_ENUM(NSInteger, SignInDetailMode) {
    SignInDetailMode_check,
    SignInDetailMode_approve,
    SignInDetailMode_notApprove,
    SignInDetailMode_finish,
};

/*
 * Description ChooseEmployeeMode 选择员工样式
 * ChooseEmployeeMode_single 单选
 * ChooseEmployeeMode_multiple 多选
 */

typedef NS_ENUM(NSInteger, ChooseEmployeeMode) {
    ChooseEmployeeMode_single,
    ChooseEmployeeMode_multiple,
};

/**
 LegworkSignInMode 签到、签退、完成、子用户状态
 
 - LegworkSignInMode_signIn: 签到
 - LegworkSignInMode_signOut: 签退
 - LegworkSignInMode_done: 完成
 - LegworkSignInMode_notMe: 子用户状态
 */
typedef NS_ENUM(NSInteger, LegworkSignInMode) {
    LegworkSignInMode_signIn,
    LegworkSignInMode_signOut,
    LegworkSignInMode_done,
    LegworkSignInMode_notMe,
};

/**
 InOutStockType 出入库类型
 
 - InOutStockType_inType: 入库类型
 - InOutStockType_outType: 出库类型
 - InOutStockType_unknowType: 未知类型
 */
typedef NS_ENUM(NSInteger, InOutStockType) {
    InOutStockType_inType,
    InOutStockType_outType,
    InOutStockType_unknowType
};

/**
 OrderEnterType 单据进入类型

 - OrderEnterType_add: 新增
 - OrderEnterType_check: 查看
 - OrderEnterType_choose: 选择
 - OrderEnterType_change_forCRM: 转换
 */
typedef NS_ENUM(NSInteger, OrderEnterType) {
    OrderEnterType_add = 0,
    OrderEnterType_check,
    OrderEnterType_choose,
    OrderEnterType_change_forCRM,
};

/**
  工作台调整类型
 
 - OrderSalesType_sales:   销售类型
 - OrderSalesType_purchas: 采购类型
 */
typedef NS_ENUM(NSInteger, OrderSalesType) {
    OrderSalesType_sales = 0,
    OrderSalesType_purchas,
};

/**
 WorkAdjustType 单据销售类型
 
 - WorkAdjustType_workT:   工作台类型
 - OrderSalesType_workMod: 模块类型
 */
typedef NS_ENUM(NSInteger, WorkAdjustType) {
    WorkAdjustType_workT = 0,
    WorkAdjustType_workMod,
};


/**
 CRMType CRM模块类型

 - CRMType_clew: 线索池类型
 - CRMType_customer: 客户类型
 - CRMType_salesClew: 销售线索类型
 - CRMType_highSeas: 公海类型
 */
typedef NS_ENUM(NSInteger, CRMType) {
    CRMType_salesClew = 0,
    CRMType_clew,
    CRMType_customer,
    CRMType_highSeas,
};

/**
 LegworkType 外勤模块类型
 
 - LegworkType_record: 外勤跟踪
 - LegworkType_approve: 外勤审批
 */
typedef NS_ENUM(NSInteger, LegworkType) {
    LegworkType_record = 0,
    LegworkType_approve,
};


/**
 TableViewCellType 创建类型

 - TableViewCellType_custOrder: 销售类型
 - TableViewCellType_shipper: 发货类型
 - TableViewCellType_receiable: 应收应付类型
 - TableViewCellType_expense: 费用申请单类型
 - TableViewCellType_buyingRequistion: 请购单类型
 - TableViewCellType_workticket: 工票单类型
 - TableViewCellType_quote: 销售报价
 - TableViewCellType_logistics
 - TableViewCellType_logisticsNotice
 - TableViewCellType_invoice: 销售、采购 发票
 - TableViewCellType_woReceipt: 生产入库、其他出入库单
 - TableViewCellType_inventory: 盘盈、盘亏单
 - TableViewCellType_cash: 收、付款单
 - TableViewCellType_inquiry : 询价单
 */
typedef NS_ENUM(NSInteger, TableViewCellType) {
    TableViewCellType_custOrder,
    TableViewCellType_shipper,
    TableViewCellType_receiable,
    TableViewCellType_expense,
    TableViewCellType_buyingRequistion,
    TableViewCellType_workticket,
    TableViewCellType_quote,
    TableViewCellType_quoteNew,
    TableViewCellType_logistics,
    TableViewCellType_logisticsNotice,
    TableViewCellType_invoice,
    TableViewCellType_contact,
    TableViewCellType_woReceipt,
    TableViewCellType_workerOrder,
    TableViewCellType_inventory,
    TableViewCellType_cash,
    TableViewCellType_inquiry,
    TableViewCellType_pgd,  //派工单
    TableViewCellType_CoReturn, //销售退货单
    TableViewCellType_payout,   //其他收付款单
    TableViewCellType_workPlan, //计划
    TableViewCellType_WPForMe,//我的计划列表
    TableViewCellType_WPForDept,//部门计划列表
    TableViewCellType_WPForCheckUnEdit, //查看计划详情不可编辑的状态
    TableViewCellType_WPForCheckEdit, //查看计划详情可以编辑的状态
    TableViewCellType_WorkOrder_cp, //生产单-产品
    TableViewCellType_WordOrder_gx, //生产单-工序
    TableViewCellType_WordOrder_cl, //生产单-材料
    
};

typedef NS_ENUM(NSInteger, ListCellType) {
    ListCellType_department,
};

/**
 类别类型

 - DefaultCategoryType_materialType: 物料类别
 - DefaultCategoryType_vendorType: 供应商类别
 - DefaultCategoryType_customerType: 客户类别
 - DefaultCategoryType_wareHouseType: 物料仓库
 - DefaultCategoryType_expenseType: 费用项目
 - DefaulaCategoryType_progressType: 进度状态
 - DefaulaCategoryType_staff: 员工
 - DefaulaCategoryType_colleague: 同事
 - DefaulaCategoryType_DepartMent:部门

 */
typedef NS_ENUM(NSInteger, DefaultCategoryType) {
    DefaultCategoryType_materialType = 0,
    DefaultCategoryType_vendorType,
    DefaultCategoryType_customerType,
    DefaultCategoryType_wareHouseType,
    DefaultCategoryType_expenseType,
    DefaulaCategoryType_progressType,
    DefaulaCategoryType_staff,
    DefaulaCategoryType_colleague,
    DefaulaCategoryType_DepartMent
};

/**
 收付款单 进入类型
 
 - PaymentCashOrderType_payment: 付款类型
 - PaymentCashOrderType_cash: 收款类型
 */
typedef NS_ENUM(NSInteger, PaymentCashOrderType) {
    PaymentCashOrderType_payment,
    PaymentCashOrderType_cash,
    PaymentCashOrderType_P_payment,
    PaymentCashOrderType_P_cash,
};

/**
 管理镖旗 进入类型
 
 - SWOTDetailEnterType_normal: 普通
 - SWOTDetailEnterType_select: 选择
 */
typedef NS_ENUM(NSInteger, SWOTDetailEnterType) {
    SWOTDetailEnterType_normal,
    SWOTDetailEnterType_select,
};

/**
 基础部门列表 进入类型
 
 - DepartmentVCType_normalType: 普通
 - DepartmentVCType_chooseType: 选择
 */
typedef NS_ENUM(NSInteger, DepartmentVCType) {
    DepartmentVCType_normalType = 0,
    DepartmentVCType_chooseType,
};

/**
 员工列表 进入类型
 
 - StaffVCType_normalType: 普通
 - StaffVCType_chooseType: 选择
 - StaffVCType_MoreType:   多选
 - StaffVCType_SelectListType 已选列表
 */
typedef NS_ENUM(NSInteger, StaffVCType) {
    StaffVCType_normalType = 0,
    StaffVCType_chooseType,
    StaffVCType_MoreType,
    StaffVCType_SelectListType,
    StaffVCType_WidthType //屏幕宽度，用于搜索页面
};

/**
设备资料-履历信息

- EqmRepairRecordType_Maintain: 保养记录
- EqmRepairRecordType_EqmRepair: 维修记录
- EqmRepairRecordType_EqmCheck:  点检记录
- EqmRepairRecordType_EqmParts 备件更换
*/
typedef NS_ENUM(NSInteger, EqmRepairRecordType) {
    EqmRepairRecordType_Maintain,
    EqmRepairRecordType_EqmRepair,
    EqmRepairRecordType_EqmCheck,
    EqmRepairRecordType_EqmParts,
};




UIKIT_EXTERN CGFloat const fontSize_10;
UIKIT_EXTERN CGFloat const fontSize_11;
UIKIT_EXTERN CGFloat const fontSize_12;
UIKIT_EXTERN CGFloat const fontSize_14;
UIKIT_EXTERN CGFloat const fontSize_15;
UIKIT_EXTERN CGFloat const fontSize_16;
UIKIT_EXTERN CGFloat const fontSize_18;
UIKIT_EXTERN CGFloat const fontSize_20;

//默认 距离
UIKIT_EXTERN CGFloat const Space_15;

/**
 * ccz 手工消息 交易类型 orderType
 * @prama P_CustomerType 销售方为 CustOrder
 * @prama p_PurchaseType 采购方为 PurcOrder
 */
UIKIT_EXTERN NSString *const P_CustomerOrder;
UIKIT_EXTERN NSString *const P_PurchaseOrder;


/**
 * ccz 交易类型 orderType
 */
// 销售

UIKIT_EXTERN NSString *const OrderType_CustOrder;          // 销售订单
UIKIT_EXTERN NSString *const OrderType_Shipper;//   @"Shipper"              // 销售发货单
UIKIT_EXTERN NSString *const OrderType_CoReturn;//  @"CoReturn"             // 销售退货单
UIKIT_EXTERN NSString *const OrderType_CustOrderChang;// @"CustOrderChang"  // 销售订单变更单
UIKIT_EXTERN NSString *const OrderType_ShipperNotice;// @"ShipperNotice"    // 销售发货通知单
UIKIT_EXTERN NSString *const OrderType_TempShipper;// @"TempShipper"        // 销售暂发单
UIKIT_EXTERN NSString *const OrderType_SaleContract;// @"SaleContract"      // 销售合同
// 采购
UIKIT_EXTERN NSString *const OrderType_PurchaseOrder;// @"PurchaseOrder"    // 采购订单
UIKIT_EXTERN NSString *const OrderType_PurReceipt;// @"PurReceipt"          // 采购收货单
UIKIT_EXTERN NSString *const OrderType_PoReturn;// @"PoReturn"              // 采购退货单
UIKIT_EXTERN NSString *const OrderType_PurOrderChang;// @"PurOrderChang"    // 采购变更单
UIKIT_EXTERN NSString *const OrderType_ReceNotice;// @"ReceNotice"          // 收货通知单
UIKIT_EXTERN NSString *const OrderType_PurTempReceipt;// @"PurTempReceipt"  // 采购暂收单
UIKIT_EXTERN NSString *const OrderType_PoRtnNotice; //                      //采购退货通知单
UIKIT_EXTERN NSString *const OrderType_PurcContract;// @"PurcContract"      // 采购合同
// 应收应付
UIKIT_EXTERN NSString *const OrderType_ActReceivable;// @"ActReceivable"    // 应收账单
UIKIT_EXTERN NSString *const OrderType_ActPayable;// @"ActPayable"          // 应付账单
// 收付款
UIKIT_EXTERN NSString *const OrderType_Cash;// @"Cash"                      // 收款单
UIKIT_EXTERN NSString *const OrderType_Payment;// @"Payment"                // 付款单
UIKIT_EXTERN NSString *const OrderType_Pcash;// = @"Pcash";                      // 预收款单

// 生产入库单
UIKIT_EXTERN NSString *const OrderType_WoReceipt;// @"WoReceipt"            // 生产入库单
UIKIT_EXTERN NSString *const OrderType_InvQc;// @"InvQc"            // 其他出库单
UIKIT_EXTERN NSString *const OrderType_InvQr;// @"InvQr"            // 其他入库单
UIKIT_EXTERN NSString *const OrderType_WorkOrder; // = @"WorkOrder";   // 生产单
UIKIT_EXTERN NSString *const OrderType_Payout; // = @"Payout";   // 其他收付款单
UIKIT_EXTERN NSString *const OrderType_PGD;// = @"LABOR_PGD";   // 派工单
UIKIT_EXTERN NSString *const OrderType_Issue;// = @"Issue";     //生产领料单
//盘盈盘亏  whw
UIKIT_EXTERN NSString *const OrderType_InvPk;// @"InvPk"     //盘亏单
UIKIT_EXTERN NSString *const OrderType_InvPy;// @"InvPy"     //盘盈单

UIKIT_EXTERN NSString *const OrderType_CustCharge;// @"CustCharge"   // 费用申请单
UIKIT_EXTERN NSString *const OrderType_Requisition;// @"Requisition"  // 请购单
UIKIT_EXTERN NSString *const OrderType_TICKET;// @"TICKET"  // 工票单
UIKIT_EXTERN NSString *const OrderType_Invoice;// = @"Invoice";  // 销售发票单
UIKIT_EXTERN NSString *const OrderType_PurInvoice;// = @"PurInvoice";  // 采购发票单

UIKIT_EXTERN NSString *const OrderType_Assembly;// = @"Assembly";  // 组装单
UIKIT_EXTERN NSString *const OrderType_Disassembly;// = @"Disassembly";  // 拆卸单

UIKIT_EXTERN NSString *const OrderType_Po_Isser_Type;// @"Po_Isser_Type"  // 单据类型
UIKIT_EXTERN NSString *const OrderType_PaymentTerm;// @"PaymentTerm"  // 付款条件
UIKIT_EXTERN NSString *const OrderType_Project;// = @"Project";  // 项目

//MARK:- CRM
UIKIT_EXTERN NSString *const OrderType_SaleCue;// = @"SaleCue";   // 销售线索
UIKIT_EXTERN NSString *const OrderType_SaleRecord; // 销售记录
UIKIT_EXTERN NSString *const OrderType_Document;   // 文件
UIKIT_EXTERN NSString *const OrderType_CustLinkMan;// 联系人
UIKIT_EXTERN NSString *const OrderType_ShiptoAddr; // 发货地址
UIKIT_EXTERN NSString *const OrderType_Cust_Ad_File; // 附件
UIKIT_EXTERN NSString *const OrderType_UserInfo;//  = @"UserInfo "; // 推送对象
UIKIT_EXTERN NSString *const OrderType_EmpOutRec;// = @"EmpOutRec"; // 外勤详情
UIKIT_EXTERN NSString *const OrderType_CustStage;// = @"CustStage"; // 销售流程
UIKIT_EXTERN NSString *const OrderType_VisitPlan;// = @"VisitPlan"; // 拜访计划
UIKIT_EXTERN NSString *const OrderType_VisitSum;// = @"VisitSum"; // 拜访总结
UIKIT_EXTERN NSString *const OrderType_Business;// = @"Business"; // 商机
UIKIT_EXTERN NSString *const OrderType_CustStage;// = @"CustStage"; // 销售分期
UIKIT_EXTERN NSString *const OrderType_VisitCode;// = @"VisitCode"; // 拜访类型


// CRM 第三阶段
UIKIT_EXTERN NSString *const OrderType_WorkTask;// = @"WorkTask"; // 任务
UIKIT_EXTERN NSString *const OrderType_customer_source;// = @"customer_source"; // 客户来源
UIKIT_EXTERN NSString *const OrderType_AskVacation;// = @"AskVacation"; // 请假单
UIKIT_EXTERN NSString *const OrderType_WorkPlan; // = @"WorkPlan"


// 工作
UIKIT_EXTERN NSString *const OrderType_CustVendFollow;// = @"CustVendFollow";  // 业务联系单


// 基础资料
UIKIT_EXTERN NSString *const OrderType_Tax_Id;// = @"Tax_Id";  // 税目明细
UIKIT_EXTERN NSString *const OrderType_Brand;// = @"Brand";  // 品牌
UIKIT_EXTERN NSString *const OrderType_Location;// = @"Location"; // 仓库
UIKIT_EXTERN NSString *const OrderType_units;// @"units";   // 计量单位
UIKIT_EXTERN NSString *const OrderType_Customer;   // 客户资料
UIKIT_EXTERN NSString *const OrderType_Vendor;   // 供应商资料
UIKIT_EXTERN NSString *const OrderType_ProductOnShelves;// = @"ProductOnShelves";   // 上架商品
UIKIT_EXTERN NSString *const OrderType_UnderStock; // 低于库存查询
UIKIT_EXTERN NSString *const OrderType_OverStock;//= @"546";   // 高于库存查询


// 其他
UIKIT_EXTERN NSString *const OrderType_Item;// = @"Item"; // 费用项目
UIKIT_EXTERN NSString *const OrderType_PurQuote;// = @"PurQuote"; // 采购报价
UIKIT_EXTERN NSString *const OrderType_Quote;// = @"Quote"; // 销售报价
UIKIT_EXTERN NSString *const OrderType_PurInquiry;// = @"PurInquiry";     //采购询价
UIKIT_EXTERN NSString *const OrderType_CustomerFollow; //客户联络单
UIKIT_EXTERN NSString *const OrderType_CustomerFollow2; // = @"CustomerFollow2"; // 商机联络单
UIKIT_EXTERN NSString *const OrderType_LogisticsNotice; // 销售物流通知单
UIKIT_EXTERN NSString *const OrderType_PurLogisticsNotice; // 采购物流通知单
UIKIT_EXTERN NSString *const OrderType_Logistics; // 销售物流单
UIKIT_EXTERN NSString *const OrderType_PurLogistics; // 采购物流单

UIKIT_EXTERN NSString *const OrderType_Progress;   // 进度状态

UIKIT_EXTERN NSString *const OrderType_PartLotno;// = @"PartLotno";   // 批号
UIKIT_EXTERN NSString *const OrderType_PartSno;// = @"PartSno";   // 序列号

UIKIT_EXTERN NSString *const OrderType_Business;//  = @"Business"; // 商机

// 自动编码
UIKIT_EXTERN NSString *const OrderType_SysBillSetup;// = @"SysBillSetup";   // 自动编码

UIKIT_EXTERN NSString *const OrderType_WorkSchedule; // = @"WorkSchedule" 获取具体某一天的日程时间列表
UIKIT_EXTERN NSString *const OrderType_WorkPlan; // = @"WorkPlan" //工作计划

UIKIT_EXTERN NSString *const OrderType_ContactCustomer;// = @"ContactCustomer";//联系客户

UIKIT_EXTERN NSString *const OrderType_CallRepairRecord;// = @"CallRepairRecord";//维修记录来自报修记录消息

// 易采集设备管理
UIKIT_EXTERN NSString *const YCJType_Equipment; //= @"Equipment";//设备资料
UIKIT_EXTERN NSString *const YCJType_EquipmentCategory; // = @"EquipmentCategory";//设备类别
UIKIT_EXTERN NSString *const YCJType_FixArea; // = @"FixArea";//安装地点
//NSString *const YCJType_FixArea = @"";//维护人员
UIKIT_EXTERN NSString *const YCJType_MaintainGrade; // = @"MaintainGrade";//保养等级
UIKIT_EXTERN NSString *const YCJType_MaintainPlan; // = @"MaintainPlan";//保养计划
UIKIT_EXTERN NSString *const YCJType_EqmCheckItem; // = @"EqmCheckItem";//点检项目
UIKIT_EXTERN NSString *const YCJType_EqmCheckProject; // = @"EqmCheckProject";//点检方案
//UIKIT_EXTERN NSString *const YCJType_MaintainPlan; // = @"MaintainPlan";//保养计划
// 自动编码 类型
UIKIT_EXTERN NSString *const BaseType_B;// = @"B";   // 自动编码 单据
UIKIT_EXTERN NSString *const BaseType_D;// = @"D";   // 自动编码 基础资料

// 自动编码 type_id
UIKIT_EXTERN NSString *const BaseType_id_PURC_ORDER;// = @"PURC_ORDER";   // 自动编码 采购订单
UIKIT_EXTERN NSString *const BaseType_id_CUST_ORDER;// = @"CUST_ORDER";   // 自动编码 销售订单
UIKIT_EXTERN NSString *const BaseType_id_SaleCue;// = @"SaleCue";         // 自动编码 销售线索
UIKIT_EXTERN NSString *const BaseType_id_Customer;// = @"Customer";       // 自动编码 客户资料

// bankCard
UIKIT_EXTERN NSString *const OrderType_CustomerBankCard;// = @"CustomerBankCard";  // 客户银行卡
UIKIT_EXTERN NSString *const OrderType_BankCard;// = @"BankCard";   // 银行卡

// ccz 通知 宏
UIKIT_EXTERN NSString *const dxda_notificationUpdateSupplier;// @"notificationUpdateSupplier"   // 更新或新增供应商资料
UIKIT_EXTERN NSString *const dxda_notificationUpdateCustomer;// @"notificationUpdateCustomer"   // 更新或新增客户资料
UIKIT_EXTERN NSString *const dxda_notificationUpdateEmployeesData;// @"notificationUpdateEmployeesData"   // 更新或新增员工资料
UIKIT_EXTERN NSString *const dxda_notificationUpdateTaxData;// @"notificationUpdateTaxData"   // 更新或新增税目
UIKIT_EXTERN NSString *const dxda_notificationUpdateMaterialData;// @"notificationUpdateMaterialData"   // 更新或新增物料
UIKIT_EXTERN NSString *const dxda_notificationUpdateDepartmentData;// @"notificationUpdateDepartmentData"   // 更新或新增部门资料

UIKIT_EXTERN NSString *const dxda_notificationUpdateBrandData;// @"notificationUpdateBrandData"   // 更新或新增品牌资料
UIKIT_EXTERN NSString *const dxda_notificationAddOrUpdateInvoicesList;// @"notificationAddOrUpdateInvoicesList"   // 新增或者更新单据
UIKIT_EXTERN NSString *const dxda_notificationUpdateContactList;// @"notificationUpdateContactList"   // 新增或者更新业务联系单
UIKIT_EXTERN NSString *const dxda_notificationUpdateUnitOfMeasurement;// @"notificationUpdateUnitOfMeasurement"   // 更新或新增计量单位

UIKIT_EXTERN NSString *const dxda_notificationUpdateBankCardInfos;// = @"notificationUpdateBankCardInfos";   // 更新银行卡信息
UIKIT_EXTERN NSString *const dxda_notificationUpdateBankCardList;// = @"notificationUpdateBankCardList";   // 更新银行卡列表

UIKIT_EXTERN NSString *const dxda_notificationUpdateScanValue;// @"notificationUpdateScanValue"  // 扫描后字符串
UIKIT_EXTERN NSString *const dxda_notificationCheckDetailDeleteActionNoty;// @"notificationCheckDetailDeleteActionNoty"  // 查看详情 删除单据发的通知

UIKIT_EXTERN NSString *const dxda_notificationTemporaryClosure;// @"TemporaryClosure"  // 临时关闭
UIKIT_EXTERN NSString *const dxda_notificationDetailVCPush;// @"DetailVCPush"  // 根据单据类型查看详情
UIKIT_EXTERN NSString *const dxda_notificationUpdateAddressList;// @"notificationUpdateAddressList"   // 更新或新增地址信息
UIKIT_EXTERN NSString *const dxda_notificationUpdateGoodsList;// @"notificationUpdateGoodsList"   // 更新或新增商品信息
UIKIT_EXTERN NSString *const dxda_notificationUpdateUserInfos;// = @"notificationUpdateGoodsList";   // 更新用户信息

UIKIT_EXTERN NSString *const CRM_notificationUpdateCRMList;// = @"notificationUpdateCRMList";   // 更新或新增线索
UIKIT_EXTERN NSString *const CRM_notificationUpdateLegworkList;// = @"notificationUpdateLegworkList";   // 刷新外勤跟踪列表
UIKIT_EXTERN NSString *const CRM_notificationUpdateVisitPlanList;// = @"notificationUpdateVisitPlanList";   // 刷新拜访记录列表
UIKIT_EXTERN NSString *const CRM_notificationUpdateStageChange;// = @"notificationUpdateStageChange";   // 刷新阶段变化
UIKIT_EXTERN NSString *const CRM_notyUpdateMissionList;// = @"notyUpdateMissionList";   // 刷新任务列表
UIKIT_EXTERN NSString *const CRM_notyUpdateMissionDetail;// = @"notyUpdateMissionDetail";   // 刷新任务详情
UIKIT_EXTERN NSString *const CRM_notySendMissionMessage;// = @"notySendMissionMessage";   // 发送任务消息

UIKIT_EXTERN NSString *const CRM_notyUpdateVisitInfos;// = @"notyUpdateVisitInfos";   // 刷新拜访信息

// ccz 提示字符
UIKIT_EXTERN NSString *const ErrorText;// @"网络出错"
UIKIT_EXTERN NSString *const LoadingText;// @"加载中..."

// ccz 商城店铺
UIKIT_EXTERN NSString *const DXDA_HttpSelectSupplier;// @"/Page/ShelvesPhone/SelectSupplier.aspx"

// ccz 销售报表 HTTP
UIKIT_EXTERN NSString *const DXDA_HttpSalesAnalyze;// @"/Page/Reports/PhoneSalesAnalyze.aspx"   // 销售分析
UIKIT_EXTERN NSString *const DXDA_HttpSalesReport; // @"/Page/Reports/PhoneSalesReport.aspx"    // 销售报表
UIKIT_EXTERN NSString *const DXDA_HttpGoodsAnalyze;// @"/Page/Reports/PhoneProductAnalyze.aspx" // 商品分析

// KPI报表
UIKIT_EXTERN NSString *const DXDA_HttpKPIReport;   // @"/Page/Reports/SalesKPICheck.aspx" // KPI报表

// ccz 消息 BI报表
UIKIT_EXTERN NSString *const DXDA_NewsBIReport;// @"/Page/Reports/BIReport.aspx"

// ccz CRM 商机报表
UIKIT_EXTERN NSString *const CRM_OpprotunityBIReport;// = @"Page/Reports/BusinessReport.aspx";

// CRM 销售漏斗
UIKIT_EXTERN NSString *const CRM_Sale_Funnel; // = @"/Page/Sale/sale_funnel.aspx";
// CRM 销售活动统计
UIKIT_EXTERN NSString *const CRM_Sales_Activities; // = @"/Page/Sale/SalesActivity.aspx";
//CRM 商机趋势
UIKIT_EXTERN NSString *const CRM_Business_Trend;
//CRM KPI报表
UIKIT_EXTERN NSString *const CRM_Dimension;
//知识库
UIKIT_EXTERN NSString *const CRM_BasicData;
//计划总结报表
UIKIT_EXTERN NSString *const CRM_PlanSumReport;
//AI报表
UIKIT_EXTERN NSString *const CRM_AIReport;
//经营分析平台
UIKIT_EXTERN NSString *const CRM_Index;
//经营分析平台
UIKIT_EXTERN NSString *const CRM_CustDimensionReport;
// ccz 权限设置开启
UIKIT_EXTERN BOOL const OpenAuthority;// NO
//UIKIT_EXTERN BOOL const OpenAuthority YES


/*============分割线==========================*/

//MARK: - 权限字段
UIKIT_EXTERN NSString *const Authority_CustOrder;// @"0202"       //订单录入
UIKIT_EXTERN NSString *const Authority_Shipper;// @"0204"         //销售发货
UIKIT_EXTERN NSString *const Authority_CoReturn;// = @"0205";         //销售退货
UIKIT_EXTERN NSString *const Authority_ShipperNotice;// = @"0213";         //发货通知单
UIKIT_EXTERN NSString *const Authority_TempShipper;// = @"0214";         //销售暂发单
UIKIT_EXTERN NSString *const Authority_CustomerData;// @"0605"    //客户资料
UIKIT_EXTERN NSString *const Authority_PurQuote;// = @"0104";     //采购报价单
UIKIT_EXTERN NSString *const Authority_PurInquiry;// = @"0103";     //采购询价
UIKIT_EXTERN NSString *const Authority_PurchaseOrder;// @"0105"   //采购订单
UIKIT_EXTERN NSString *const Authority_PurReceipt;// @"0107"      //采购收货
UIKIT_EXTERN NSString *const Authority_ReceNotice;   // 收货通知单
UIKIT_EXTERN NSString *const Authority_PoRtnNotice;    //采购退货通知单
UIKIT_EXTERN NSString *const Authority_PoReturn;// = @"0108";     //采购退货
UIKIT_EXTERN NSString *const Authority_PurTempReceipt;// = @"0112";     //采购暂收单
UIKIT_EXTERN NSString *const Authority_WoReceipt;// @"0310"       //生产入库单
UIKIT_EXTERN NSString *const Authority_BusinessConnection;// @"0912"  //业务联系单
UIKIT_EXTERN NSString *const Authority_Cash;// @"0402"            //收款单
UIKIT_EXTERN NSString *const Authority_Payment;// @"0404"         //付款单
UIKIT_EXTERN NSString *const Authority_ActReceivable;// @"0401"   //应收账单
UIKIT_EXTERN NSString *const Authority_ActPayable;// @"0403"       //应付账单
UIKIT_EXTERN NSString *const Authority_SalesReport;// @"0801003"  //销售报表
UIKIT_EXTERN NSString *const Authority_InvQr;// @"0301"           // 其他入库单
UIKIT_EXTERN NSString *const Authority_InvQc;// @"0302"           // 其他出库单
UIKIT_EXTERN NSString *const Authority_Payout;// = @"04001";         //其他收付款单
UIKIT_EXTERN NSString *const Authority_Issue;// = @"1104";//生产领料单
UIKIT_EXTERN NSString *const Authority_Profit;// @"0304"          // 盘盈单
UIKIT_EXTERN NSString *const Authority_Loss;// @"0305"            // 盘亏单
UIKIT_EXTERN NSString *const Authority_Material_maintain;// @"0601"   // 物料维护
UIKIT_EXTERN NSString *const Authority_Material_category;// @"0602"   // 物料类别
UIKIT_EXTERN NSString *const Authority_Unit;// @"0603"   // 计量单位
UIKIT_EXTERN NSString *const Authority_Material_warehouse;// @"0604"   // 物料仓库
UIKIT_EXTERN NSString *const Authority_Customer_infos;// @"0605"       // 客户资料
UIKIT_EXTERN NSString *const Authority_Customer_category;// @"0606"    // 客户类别
UIKIT_EXTERN NSString *const Authority_Vendor_infos;// @"0607"         // 供应商资料
UIKIT_EXTERN NSString *const Authority_Vendor_category;// @"0608"      // 供应商类别
UIKIT_EXTERN NSString *const Authority_Company_infos;// @"0609"        // 企业资料
UIKIT_EXTERN NSString *const Authority_Address_maintain;// @"0610"     // 地址维护
UIKIT_EXTERN NSString *const Authority_Emploryee_infos;// @"0611"      // 员工资料
UIKIT_EXTERN NSString *const Authority_Department_infos;// @"0612"     // 部门资料
//UIKIT_EXTERN NSString *const Authority_Material_maintain @"613"   // 货币资料
UIKIT_EXTERN NSString *const Authority_Tax_infos;// @"0614"   // 税目明细
UIKIT_EXTERN NSString *const Authority_Brand_infos;// @"0620"  // 品牌
UIKIT_EXTERN NSString *const Authority_Address_infos;// @"0622"   // 收货地址

UIKIT_EXTERN NSString *const Authority_M0801001;// = "0801001";  // 财务基础报表
UIKIT_EXTERN NSString *const Authority_M0801002;// = "0801002";  // 商品分析
UIKIT_EXTERN NSString *const Authority_M0801003;// = "0801003";  // 销售报表
UIKIT_EXTERN NSString *const Authority_M0801004;// = "0801004";  // 销售分析

UIKIT_EXTERN NSString *const Authority_BuyingRequisition;// = @"0114";   // 请购单
UIKIT_EXTERN NSString *const Authority_CustomerContact;// = @"0209";   // 客户联络单
UIKIT_EXTERN NSString *const Authority_ExpenseList;// @""   // 费用申请单
UIKIT_EXTERN NSString *const Authority_ExpenseProject;// = @"费用项目";   // 费用项目
UIKIT_EXTERN NSString *const Authority_PGD; // = @"1102";   // 派工单
UIKIT_EXTERN NSString *const Authority_Ticket;// = @"1103";   // 工票单
UIKIT_EXTERN NSString *const Authority_Quote;// = @"0201";   // 销售报价
UIKIT_EXTERN NSString *const Authority_Invoice;// = @"0212";   // 销售发票
UIKIT_EXTERN NSString *const Authority_PurInvoice;// = @"0110";   // 采购发票

UIKIT_EXTERN NSString *const Authority_Logistics; // 销售物流单
UIKIT_EXTERN NSString *const Authority_PurLogistics; //  采购物流单
UIKIT_EXTERN NSString *const Authority_LogisticsNotice; // 销售物流通知单
UIKIT_EXTERN NSString *const Authority_PurLogisticsNotice; // 采购物流通知单

UIKIT_EXTERN NSString *const Authority_Progress; // 进度状态
UIKIT_EXTERN NSString *const Authority_BI;   // BI报表

UIKIT_EXTERN NSString *const Authority_Listing;// = @"0405";   // 挂牌单
UIKIT_EXTERN NSString *const Authority_Delisting;// = @"0407";   // 摘牌
UIKIT_EXTERN NSString *const Authority_FinancialAssets;// = @"0702";   // 资产单
UIKIT_EXTERN NSString *const Authority_WorkOrder; // = @"1101";   // 生产单

// 上架商品
UIKIT_EXTERN NSString *const Authority_UpSelfGoods;// = @"0619";   // 上架商品 0619
UIKIT_EXTERN NSString *const Authority_UnderStock;//= @"546";   // 低于库存查询
UIKIT_EXTERN NSString *const Authority_OverStock;//= @"546";   // 高于库存查询


// 我的模块
UIKIT_EXTERN NSString *const Authority_InviteRegister;// = "0904";        // 邀请注册
UIKIT_EXTERN NSString *const Authority_SendMessage;// = "0911";        // 发送消息
UIKIT_EXTERN NSString *const Authority_AboutUs;// = "0914";        // 关于我们
UIKIT_EXTERN NSString *const Authority_BankCard;// = "0916";        // 银行卡管理
UIKIT_EXTERN NSString *const Authority_CompanyAuthentication;// = "0917";        // 企业认证

// CRM
UIKIT_EXTERN NSString *const Authority_CRM;// = @"0687";            // CRM
UIKIT_EXTERN NSString *const Authority_SaleCue;// = @"0641";        // 销售线索
UIKIT_EXTERN NSString *const Authority_salesFunnel; // = @"17002";        // 销售漏斗
UIKIT_EXTERN NSString *const Authority_salesActivities; // = @"17009";        // 销售活动统计

UIKIT_EXTERN NSString *const Authority_AIReport;// = @"17034"; //ai报表
UIKIT_EXTERN NSString *const Authority_CustDimensionReport; // = @"171503";//客户维度报表

UIKIT_EXTERN NSString *const Authority_Dimension; // = @"17030"; //kpi报表
UIKIT_EXTERN NSString *const Authority_clew;// = @"0642";           // 线索池
UIKIT_EXTERN NSString *const Authority_highSeas;// = @"0643";       // 公海

UIKIT_EXTERN NSString *const Authority_EmpOutRec;// = @"0646";      // 外勤
UIKIT_EXTERN NSString *const Authority_VisitPlan;// = @"0647";      // 拜访计划
UIKIT_EXTERN NSString *const Authority_VisitSum;// = @"0648";       // 拜访总结
UIKIT_EXTERN NSString *const Authority_Business;// = @"0649";       // 商机
UIKIT_EXTERN NSString *const Authority_CustStage;// = @"0650";      // 销售流程
UIKIT_EXTERN NSString *const Authority_BusinessStage;// = @"0652";      // 商机阶段进度
UIKIT_EXTERN NSString *const Authority_Opportunity;// = @"0653";      // 商机报表
UIKIT_EXTERN NSString *const Authority_BusinessTrend; // = @"17029";   // 商机趋势
UIKIT_EXTERN NSString *const Authority_VisitType;// = @"0658";// 拜访类型
UIKIT_EXTERN NSString *const Authority_Schedule; // = @"12005" //日程
UIKIT_EXTERN NSString *const Authority_AskVacation; // = @"12006";     //请假单
UIKIT_EXTERN NSString *const Authority_Schedule; // = @"12005" //日程
UIKIT_EXTERN NSString *const Authority_WorkPlan;  // = @"12004"   //工作计划
UIKIT_EXTERN NSString *const Authority_SystemLog; // = @"0925";     //系统日志
UIKIT_EXTERN NSString *const Authority_BasicData; //知识库
UIKIT_EXTERN NSString *const Authority_PlanSumReport; // = @"17033";     //计划总结报表
UIKIT_EXTERN NSString *const Authority_SWOT;//= @"12007";     //SWOT

UIKIT_EXTERN NSString *const Authority_Task;// = @"1203";      // 任务

UIKIT_EXTERN NSString *const PowerID_Select;// @"Select"  //查看
UIKIT_EXTERN NSString *const PowerID_Add;// @"Add"        //新增
UIKIT_EXTERN NSString *const PowerID_Update;// @"Update"  //修改
UIKIT_EXTERN NSString *const PowerID_Delete;// @"Delete"  //删除
UIKIT_EXTERN NSString *const PowerID_Appr;// @"Appr"      //审批
UIKIT_EXTERN NSString *const PowerID_Anti;// @"Anti"      //反审批
UIKIT_EXTERN NSString *const PowerID_Nextstep;// @"Nextstep"      //产生下级单据
UIKIT_EXTERN NSString *const PowerID_Print;// @"Print"      //打印
UIKIT_EXTERN NSString *const PowerID_Export;// @"Export"      // 导出
UIKIT_EXTERN NSString *const PowerID_Import;// @"Import"      // 导入

UIKIT_EXTERN NSString *const NoPower;// @"没有操作权限"
UIKIT_EXTERN NSString *const Checking;// = @"检查中...";


//MARK: 自动编码
UIKIT_EXTERN NSString *const CategoryType_product_category;// @"product_category";  // 物料类别
UIKIT_EXTERN NSString *const CategoryType_vendor_category;// @"vendor_category";  // 供应商类别
UIKIT_EXTERN NSString *const CategoryType_customer_category;// @"customer_category";  // 客户类别
UIKIT_EXTERN NSString *const CategoryType_location_Info;// @"location_Info";  // 物料仓库
UIKIT_EXTERN NSString *const CategoryType_item;// = @"item";  // 费用项目
UIKIT_EXTERN NSString *const CategoryType_employee;// = @"employee";  员工
UIKIT_EXTERN NSString *const CategoryType_brand;// = @"brand";  // 品牌
UIKIT_EXTERN NSString *const CategoryType_tax_id_info;// = @"tax_id_info";  // 税目
UIKIT_EXTERN NSString *const CategoryType_department;// = @"department";  // 部门
UIKIT_EXTERN NSString *const CategoryType_customer;// = @"customer";  // 客户资料
UIKIT_EXTERN NSString *const CategoryType_vendor;// = @"vendor";  // 供应商资料
UIKIT_EXTERN NSString *const CategoryType_part;// = @"part";  // 物料维护
UIKIT_EXTERN NSString *const CategoryType_unit;// = @"unit";  // 计量单位
UIKIT_EXTERN NSString *const CategoryType_progressStatus; // 进度状态

//MARK: 图文档
UIKIT_EXTERN NSString *const AccessoryType_CustomerFollow; //客户联络单
UIKIT_EXTERN NSString *const AccessoryType_PurchaseOrder; //采购
UIKIT_EXTERN NSString *const AccessoryType_PurReceipt; //采购收货
UIKIT_EXTERN NSString *const AccessoryType_CustOrder; //销售订单
UIKIT_EXTERN NSString *const AccessoryType_Shipper; //销售发货
UIKIT_EXTERN NSString *const AccessoryType_PurInvoic; //采购发票
UIKIT_EXTERN NSString *const AccessoryType_Invoic; //销售发票
UIKIT_EXTERN NSString *const AccessoryType_Payment; //付款单
UIKIT_EXTERN NSString *const AccessoryType_Cash; //收款单
UIKIT_EXTERN NSString *const AccessoryType_WoReceipt;//生产入库单
UIKIT_EXTERN NSString *const AccessoryType_Issue; //生产领料单
UIKIT_EXTERN NSString *const AccessoryType_WorkOrder; //生产单
UIKIT_EXTERN NSString *const AccessoryType_PoReturn; //采购退货
UIKIT_EXTERN NSString *const AccessoryType_CoReturn;//销售退货
UIKIT_EXTERN NSString *const AccessoryType_CustCharge;//费用申请单
UIKIT_EXTERN NSString *const AccessoryType_Quote; //销售报价单
UIKIT_EXTERN NSString *const AccessoryType_PurQuote;//采购报价单
UIKIT_EXTERN NSString *const AccessoryType_PUR_INQ; //采购询价单
UIKIT_EXTERN NSString *const AccessoryType_WorkPlan;//工作计划
UIKIT_EXTERN NSString *const AccessoryType_ActReceivable;//;//应收账单
UIKIT_EXTERN NSString *const AccessoryType_ActPayable;//;//工作计划
UIKIT_EXTERN NSString *const AccessoryType_PAYOUT; //其他收付款单；
UIKIT_EXTERN NSString *const AccessoryType_REQUIS; // //请购单
UIKIT_EXTERN NSString *const AccessoryType_QR;//其他入库单
UIKIT_EXTERN NSString *const AccessoryType_QC;//其他出库单




//MARK: MethodType
// CRM
UIKIT_EXTERN NSString *const MethodType_GetSaleCueList;// = @"GetSaleCueList" //销售线索
UIKIT_EXTERN NSString *const MethodType_GetCustomerList;// = @"GetCustomerList"; // 客户列表、公海
UIKIT_EXTERN NSString *const MethodType_OptionSaleCue;// = @"OptionSaleCue"; // 转换 作废 退回
UIKIT_EXTERN NSString *const MethodType_OptionCustomer;// = @"OptionCustomer"; // 转换 作废 退回
UIKIT_EXTERN NSString *const MethodType_GetFollowRecordList;// = @"GetFollowRecordList"; // 跟进记录
UIKIT_EXTERN NSString *const MethodType_GetDealingData;// = @"GetDealingData"; // 获取待处理总数
UIKIT_EXTERN NSString *const MethodType_GetDealingList;// = @"GetDealingList"; // 获取待处理/已处理
UIKIT_EXTERN NSString *const MethodType_OptionVisitPlan; // =  @"OptionVisitPlan"; // 拜访计划跟换／重用
UIKIT_EXTERN NSString *const MethodType_OptionBusiness; // = @"OptionBusiness"; // 商机跟换／重用
UIKIT_EXTERN NSString *const MethodType_WorkTaskOperation; // = @"WorkTaskOperation"; // 操作任务
UIKIT_EXTERN NSString *const MethodType_GetWordScheduleList; // = @"getWordScheduleList"  //获取日程时间列表
UIKIT_EXTERN NSString *const MethodType_WorkSchedule; // = @"WorkSchedule" 获取具体某一天的日程时间列表
UIKIT_EXTERN NSString *const MethodType_WorkPlan; // = @"WorkPlan" //工作计划



// CRM BI报表
// 客户总数、新增客户、拜访的客户、本期待跟进的客户、服务期内的客户、已过期的客户
//UIKIT_EXTERN NSString *const MethodType_GetCustomerList; // = @"GetCustomerList";
// 新增的商机、阶段变化的商机
UIKIT_EXTERN NSString *const MethodType_GetBusinessList; // = @"GetBusinessList";

// 获取待处理的商机
UIKIT_EXTERN NSString *const MethodType_GetApproveBusinessList;// = @"GetApproveBusinessList";

// 线索总数、转换为商机、转换为订单、转换为客户
//UIKIT_EXTERN NSString *const MethodType_GetSaleCueList; // = @"GetSaleCueList";

// Option
UIKIT_EXTERN NSString *const CRMOptionType_TransCustomer;// = @"TransCustomer";  // 转换客户
UIKIT_EXTERN NSString *const CRMOptionType_Get;// = @"Get";  // 领取
UIKIT_EXTERN NSString *const CRMOptionType_Allot;// = @"Allot";  // 分配
UIKIT_EXTERN NSString *const CRMOptionType_Disable;// = @"Disable";  // 作废
UIKIT_EXTERN NSString *const CRMOptionType_ChangeSaleman;// = @"ChangeSaleman";  // 更换业务员
UIKIT_EXTERN NSString *const CRMOptionType_ReturnCue;// = @"TransCustomer";  // 退回线索池
UIKIT_EXTERN NSString *const CRMOptionType_ReturnSea;// = @"ReturnSea";  // 退回公海
UIKIT_EXTERN NSString *const CRMOptionType_bindingCust;// = @"bindingCust";  // 绑定客户


// 外勤签到
UIKIT_EXTERN NSString *const MethodType_GetEmpOutRecList;// = @"GetEmpOutRecList"; // 外勤跟踪列表
UIKIT_EXTERN NSString *const MethodType_GetEmpOutRecAboutData;// = @"GetEmpOutRecAboutData"; // 外勤跟踪详情
UIKIT_EXTERN NSString *const MethodType_AddEmpOutRec;// = @"AddEmpOutRec"; // 外勤签到
UIKIT_EXTERN NSString *const MethodType_SignOut;// = @"SignOut"; // 外勤签退
UIKIT_EXTERN NSString *const MethodType_DocumentUploadFile;// = @"DocumentUploadFile"; // 图片上传
UIKIT_EXTERN NSString *const MethodType_GetVisitPlanList;// = @"GetVisitPlanList"; // 拜访记录
UIKIT_EXTERN NSString *const MethodType_GetDefaultSalesman;// = @"GetDefaultSalesman"; // 获取默认业务员
UIKIT_EXTERN NSString *const MethodType_GetWordScheduleList; // = @"getWordScheduleList"  //获取日程时间列表


UIKIT_EXTERN NSString *const MethodType_GetHavePlanDay;// = @"GetHavePlanDay"; // 拜访计划天数
UIKIT_EXTERN NSString *const MethodType_AddVisitPlan;// = @"AddVisitPlan"; // 新建拜访计划
UIKIT_EXTERN NSString *const MethodType_UpdateVisitPlan;// = @"UpdateVisitPlan"; // 修改拜访计划
UIKIT_EXTERN NSString *const MethodType_DelVisitPlan;// = @"DelVisitPlan"; // 删除拜访计划
UIKIT_EXTERN NSString *const MethodType_VisitPlan;// = @"VisitPlan"; // 查询拜访计划
UIKIT_EXTERN NSString *const MethodType_GetVisitSumList;// = @"GetVisitSumList"; // 查询拜访总结列表
UIKIT_EXTERN NSString *const MethodType_GetCRMReport;// = @"GetCRMReport"; // 查询 CRM BI报表
UIKIT_EXTERN NSString *const MethodType_OptionBusiness;// = @"OptionBusiness"; // 商机
UIKIT_EXTERN NSString *const MethodType_UpdateBusProcess;// = @"UpdateBusProcess"; // 更换阶段
UIKIT_EXTERN NSString *const MethodType_ApproveBusProcess;// = @"ApproveBusProcess"; // 阶段审批
UIKIT_EXTERN NSString *const MethodType_BindingSalesman;// = @"BindingSalesman"; // 绑定业务员

UIKIT_EXTERN NSString *const MethodType_SelectCusBankCard;// = @"SelectCusBankCard";  // 查询银行卡
UIKIT_EXTERN NSString *const MethodType_SaveCusBankCard;// = @"SaveCusBankCard";  // 新增、保存银行卡
UIKIT_EXTERN NSString *const MethodType_CertificationMyBankCard;// = @"CertificationMyBankCard";  // 认证银行卡

// 商城
UIKIT_EXTERN NSString *const MethodType_ShoppingCartDeleteApp;// = @"ShoppingCartDeleteApp"; // 删除购物车

// 修改手机、用户名
UIKIT_EXTERN NSString *const MethodType_SetUserInfoApp;// = @"SetUserInfoApp"; // 修改手机、用户名
UIKIT_EXTERN NSString *const MethodType_SetUserPassWord;// = @"SetUserPassWord"; // 修改密码

UIKIT_EXTERN NSString *const MethodType_DeleteBrandForList;// = @"DeleteBrandForList"; // 删除品牌

UIKIT_EXTERN NSString *const MethodType_GetAppBanner;// = @"GetAppBanner"; // 获取banner

UIKIT_EXTERN NSString *const MethodType_GetAppBannerList;// = @"GetAppBannerList"; // 获取bannerlist


// 工作台 key
UIKIT_EXTERN NSString *const MethodType_UpdateUserConfig;// = @"UpdateUserConfig";  // 更新工作台
UIKIT_EXTERN NSString *const MethodType_SelectUserConfig;// = @"SelectUserConfig";  // 查询工作台
UIKIT_EXTERN NSString *const MethodType_InitWorkPlatformModuleInfo; // = @"InitWorkPlatformModuleInfo";  // 查询工作台其他模块
UIKIT_EXTERN NSString *const MethodType_SaveWorkPlatformModuleInfo; // = @"SaveWorkPlatformModuleInfo";  // 编辑工作台其他模块

UIKIT_EXTERN NSString *const workCenterKey;// = @"dxda_workCenter_identy";

/*
 RpType CRM BI报表 类型
 */
UIKIT_EXTERN NSString *const RpType_CustZB;// = @"CustZB"; // 销售指标
UIKIT_EXTERN NSString *const RpType_CustRp;// = @"CustRp"; // 销售简报
UIKIT_EXTERN NSString *const RpType_OrderJY;// = @"OrderJY"; // 交易订单
UIKIT_EXTERN NSString *const RpType_SC;// = @"SC"; // 线索转换

/*
 BIType CRM BI报表 穿透类型
 */
UIKIT_EXTERN NSString *const BIType_CustAllQty;// = @"CustAllQty";          // 客户总数
UIKIT_EXTERN NSString *const BIType_addCustQty;// = @"addCustQty";          // 新增客户
UIKIT_EXTERN NSString *const BIType_vistCustQty;// = @"vistCustQty";        // 拜访的客户
UIKIT_EXTERN NSString *const BIType_stayCustQty;// = @"stayCustQty";        // 本期待跟进的客户
UIKIT_EXTERN NSString *const BIType_serverCustQty;// = @"serverCustQty";    // 服务期内的客户
UIKIT_EXTERN NSString *const BIType_outedCustQty;// = @"outedCustQty";      // 已过期的客户
UIKIT_EXTERN NSString *const BIType_addSaleRecordQty;// = @"addSaleRecordQty";      // 新增的销售记录
UIKIT_EXTERN NSString *const BIType_addBusinessQty;// = @"addBusinessQty";  // 新增的商机
UIKIT_EXTERN NSString *const BIType_stageChangeQty;// = @"stageChangeQty";  // 阶段变化的商机
UIKIT_EXTERN NSString *const BIType_saleCueQty;// = @"saleCueQty";          // 线索总数
UIKIT_EXTERN NSString *const BIType_transBusiness;// = @"transBusiness";    // 转换为商机
UIKIT_EXTERN NSString *const BIType_transCustomer;// = @"transCustomer";    // 转换为客户
UIKIT_EXTERN NSString *const BIType_transCustOrder;// = @"transCustOrder";  // 转换为订单

//MARK: - IM 扩展消息
UIKIT_EXTERN NSString *const IM_sendUserNike;// = @"send_message_dxda_user_nike";  // 发送昵称
UIKIT_EXTERN NSString *const IM_sendUserId;// = @"send_message_dxda_user_id";  // 发送ID
UIKIT_EXTERN NSString *const IM_sendUserHead;// = @"send_message_dxda_user_head";  // 发送头像
UIKIT_EXTERN NSString *const IM_recvUserNike;// = @"recv_message_dxda_user_nike";  // 接收昵称
UIKIT_EXTERN NSString *const IM_recvUserId;// = @"recv_message_dxda_user_id";  // 接收ID
UIKIT_EXTERN NSString *const IM_recvUserHead;// = @"recv_message_dxda_user_head";  // 接收头像

UIKIT_EXTERN NSString *const IM_Legwork_data;// = @"dxda_task_bean_json";  // 任务数据
UIKIT_EXTERN NSString *const IM_crm_task_type;// = @"message_crm_task_type";  // 是否是任务消息 BOOL



@interface DXDAExternStaticString : NSString

@end
