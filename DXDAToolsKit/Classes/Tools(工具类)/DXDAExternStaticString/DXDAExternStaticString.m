//
//  DXDAExternStaticString.m
//  NewApp3.0
//
//  Created by DXDA on 2017/7/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "DXDAExternStaticString.h"


CGFloat const fontSize_10 = 10.0f;
CGFloat const fontSize_11 = 11.0f;
CGFloat const fontSize_12 = 12.0f;
CGFloat const fontSize_14 = 14.0f;
CGFloat const fontSize_15 = 15.0f;
CGFloat const fontSize_16 = 16.0f;
CGFloat const fontSize_18 = 18.0f;
CGFloat const fontSize_20 = 20.0f;

CGFloat const Space_15 = 15.0f;

/**
 * ccz 手工消息 交易类型 orderType
 * @prama P_CustomerType 销售方为 CustOrder
 * @prama p_PurchaseType 采购方为 PurcOrder
 */
NSString *const P_CustomerOrder = @"CustOrder";
NSString *const P_PurchaseOrder =  @"PurcOrder";


/**
 * ccz 交易类型 orderType
 */
// 销售
NSString *const OrderType_CustOrder = @"CustOrder";            // 销售订单
NSString *const OrderType_Shipper =  @"Shipper";              // 销售发货单
NSString *const OrderType_CoReturn = @"CoReturn";             // 销售退货单
NSString *const OrderType_CustOrderChang = @"CustOrderChang";  // 销售订单变更单
NSString *const OrderType_ShipperNotice = @"ShipperNotice";    // 销售发货通知单
NSString *const OrderType_TempShipper = @"TempShipper";        // 销售暂发单
NSString *const OrderType_SaleContract = @"SaleContract";     // 销售合同
// 采购
NSString *const OrderType_PurchaseOrder = @"PurchaseOrder";    // 采购订单
NSString *const OrderType_PurReceipt = @"PurReceipt";          // 采购收货单
NSString *const OrderType_PoReturn = @"PoReturn";              // 采购退货单
NSString *const OrderType_PurOrderChang = @"PurOrderChang";    // 采购变更单
NSString *const OrderType_ReceNotice = @"ReceNotice";          // 收货通知单
NSString *const OrderType_PurTempReceipt = @"PurTempReceipt";  // 采购暂收单
NSString *const OrderType_PoRtnNotice = @"PoRtnNotice"; //采购退货通知单
NSString *const OrderType_PurcContract = @"PurcContract";      // 采购合同
// 应收应付
NSString *const OrderType_ActReceivable = @"ActReceivable";    // 应收账单
NSString *const OrderType_ActPayable = @"ActPayable";          // 应付账单
// 收付款
NSString *const OrderType_Cash = @"Cash";                      // 收款单
NSString *const OrderType_Payment = @"Payment";                // 付款单
NSString *const OrderType_Pcash = @"Pcash";                      // 预收款单

// 生产入库单
NSString *const OrderType_WoReceipt = @"WoReceipt";            // 生产入库单
NSString *const OrderType_InvQc = @"InvQc";            // 其他出库单
NSString *const OrderType_InvQr = @"InvQr";            // 其他入库单
//
//盘盈盘亏  whw
NSString *const OrderType_InvPk = @"InvPk";     //盘亏单
NSString *const OrderType_InvPy = @"InvPy";     //盘盈单

NSString *const OrderType_CustCharge = @"CustCharge";   // 费用申请单
NSString *const OrderType_Requisition = @"Requisition";  // 请购单
NSString *const OrderType_TICKET = @"TICKET";  // 工票单
NSString *const OrderType_Invoice = @"Invoice";  // 销售发票单
NSString *const OrderType_PurInvoice = @"PurInvoice";  // 采购发票单

NSString *const OrderType_Assembly = @"Assembly";  // 组装单
NSString *const OrderType_Disassembly = @"Disassembly";  // 拆卸单

NSString *const OrderType_Po_Isser_Type = @"Po_Isser_Type";  // 单据类型
NSString *const OrderType_PaymentTerm = @"PaymentTerm";  // 付款条件
NSString *const OrderType_Project = @"Project";  // 项目

// CRM
NSString *const OrderType_SaleCue = @"SaleCue";   // 销售线索
NSString *const OrderType_SaleRecord = @"SaleRecord"; // 销售记录
NSString *const OrderType_Document = @"Document";   // 文件
NSString *const OrderType_CustLinkMan = @"CustLinkMan";// 联系人
NSString *const OrderType_ShiptoAddr = @"ShiptoAddr"; // 发货地址
NSString *const OrderType_Cust_Ad_File = @"Cust_Ad_File"; // 附件
NSString *const OrderType_UserInfo = @"UserInfo"; // 推送对象
NSString *const OrderType_EmpOutRec = @"EmpOutRec"; // 外勤详情
NSString *const OrderType_Business  = @"Business"; // 商机
NSString *const OrderType_CustStage = @"CustStage"; // 销售流程
NSString *const OrderType_VisitPlan = @"VisitPlan"; // 拜访计划
NSString *const OrderType_VisitSum = @"VisitSum"; // 拜访总结
NSString *const OrderType_VisitCode = @"VisitCode"; // 拜访类型

// CRM 第三阶段
NSString *const OrderType_WorkTask = @"WorkTask"; // 任务
NSString *const OrderType_customer_source = @"customer_source"; // 客户来源
NSString *const OrderType_AskVacation = @"AskVacation"; // 请假单
NSString *const OrderType_WorkPlan = @"WorkPlan"; // 计划



// bankCard
NSString *const OrderType_BankCard = @"BankCard";   // 银行卡
NSString *const OrderType_CustomerBankCard = @"CustomerBankCard";  // 客户银行卡


// 工作
NSString *const OrderType_CustVendFollow = @"CustVendFollow";  // 业务联系单


// 基础资料
NSString *const OrderType_Tax_Id = @"Tax_Id";  // 税目明细
NSString *const OrderType_Brand = @"Brand";  // 品牌
NSString *const OrderType_Location = @"Location"; // 仓库
NSString *const OrderType_units = @"units";   // 计量单位
NSString *const OrderType_Customer = @"Customer";   // 客户资料
NSString *const OrderType_Vendor = @"Vendor";   // 供应商资料
NSString *const OrderType_ProductOnShelves = @"ProductOnShelves";   // 上架商品
NSString *const OrderType_UnderStock = @"UnderStock"; // 低于库存查询
NSString *const OrderType_OverStock = @"OverStock";//= @"OverStock";   // 高于库存查询
NSString *const OrderType_WorkOrder = @"WorkOrder";   // 生产单
NSString *const OrderType_Payout = @"Payout";   // 其他收付款单
NSString *const OrderType_PGD = @"LABOR_PGD";   // 派工单
NSString *const OrderType_Issue = @"Issue";     //生产领料单
// 其他
NSString *const OrderType_Item = @"Item"; // 费用项目
NSString *const OrderType_PurQuote = @"PurQuote"; // 采购报价
NSString *const OrderType_Quote = @"Quote"; // 销售报价
NSString *const OrderType_PurInquiry = @"PurInquiry";     //采购询价
NSString *const OrderType_CustomerFollow = @"CustomerFollow"; // 客户联络单

NSString *const OrderType_CustomerFollow2 = @"CustomerFollow2"; // 商机联络单


NSString *const OrderType_LogisticsNotice = @"SaleExpressNotice"; // 销售物流通知单
NSString *const OrderType_PurLogisticsNotice = @"PurcExpressNotice"; // 采购物流通知单
NSString *const OrderType_Logistics = @"SaleExpress"; // 销售物流单
NSString *const OrderType_PurLogistics = @"PurcExpress"; // 采购物流单

NSString *const OrderType_Progress = @"ProgressStatus";   // 进度状态

NSString *const OrderType_PartLotno = @"PartLotno";   // 批号
NSString *const OrderType_PartSno = @"PartSno";   // 序列号

NSString *const OrderType_WorkSchedule = @"WorkSchedule"; //获取具体某一天的日程时间列表

NSString *const OrderType_ContactCustomer = @"ContactCustomer";//联系客户

NSString *const OrderType_CallRepairRecord = @"CallRepairRecord";//维修记录来自报修记录消息

// 自动编码
NSString *const OrderType_SysBillSetup = @"SysBillSetup";   // 自动编码

// 易采集设备管理
NSString *const YCJType_Equipment = @"Equipment";//设备资料
NSString *const YCJType_EquipmentCategory = @"EquipmentCategory";//设备类别
NSString *const YCJType_FixArea = @"FixArea";//安装地点
//NSString *const YCJType_FixArea = @"";//维护人员
NSString *const YCJType_MaintainGrade = @"MaintainGrade";//保养等级
NSString *const YCJType_MaintainPlan = @"MaintainPlan";//保养计划
NSString *const YCJType_EqmCheckItem = @"EqmCheckItem";//点检项目
NSString *const YCJType_EqmCheckProject = @"EqmCheckProject";//点检方案
//NSString *const YCJType_MaintainPlan = @"MaintainPlan";//保养计划


// 自动编码 类型
NSString *const BaseType_B = @"B";   // 自动编码 单据
NSString *const BaseType_D = @"D";   // 自动编码 基础资料

// 自动编码 type_id
NSString *const BaseType_id_PURC_ORDER = @"PURC_ORDER";   // 自动编码 采购订单
NSString *const BaseType_id_CUST_ORDER = @"CUST_ORDER";   // 自动编码 销售订单
NSString *const BaseType_id_SaleCue = @"SaleCue";         // 自动编码 销售线索
NSString *const BaseType_id_Customer = @"Customer";       // 自动编码 客户资料

// ccz 通知 宏
NSString *const dxda_notificationUpdateSupplier = @"notificationUpdateSupplier";   // 更新或新增供应商资料
NSString *const dxda_notificationUpdateCustomer = @"notificationUpdateCustomer";   // 更新或新增客户资料
NSString *const dxda_notificationUpdateEmployeesData = @"notificationUpdateEmployeesData";   // 更新或新增员工资料
NSString *const dxda_notificationUpdateTaxData = @"notificationUpdateTaxData";   // 更新或新增税目
NSString *const dxda_notificationUpdateMaterialData = @"notificationUpdateMaterialData";   // 更新或新增物料
NSString *const dxda_notificationUpdateDepartmentData = @"notificationUpdateDepartmentData";   // 更新或新增部门资料

NSString *const dxda_notificationUpdateBrandData = @"notificationUpdateBrandData";   // 更新或新增品牌资料
NSString *const dxda_notificationAddOrUpdateInvoicesList = @"notificationAddOrUpdateInvoicesList";   // 新增或者更新单据
NSString *const dxda_notificationUpdateContactList = @"notificationUpdateContactList";   // 新增或者更新业务联系单
NSString *const dxda_notificationUpdateUnitOfMeasurement = @"notificationUpdateUnitOfMeasurement";   // 更新或新增计量单位

NSString *const dxda_notificationUpdateBankCardInfos = @"notificationUpdateBankCardInfos";   // 更新银行卡信息
NSString *const dxda_notificationUpdateBankCardList = @"notificationUpdateBankCardList";   // 更新银行卡列表

NSString *const dxda_notificationUpdateScanValue = @"notificationUpdateScanValue";  // 扫描后字符串
NSString *const dxda_notificationCheckDetailDeleteActionNoty = @"notificationCheckDetailDeleteActionNoty";  // 查看详情 删除单据发的通知

NSString *const dxda_notificationTemporaryClosure = @"TemporaryClosure";  // 临时关闭
NSString *const dxda_notificationDetailVCPush = @"DetailVCPush";  // 根据单据类型查看详情
NSString *const dxda_notificationUpdateAddressList = @"notificationUpdateAddressList";   // 更新或新增地址信息
NSString *const dxda_notificationUpdateGoodsList = @"notificationUpdateGoodsList";   // 更新或新增商品信息
NSString *const dxda_notificationUpdateUserInfos = @"notificationUpdateGoodsList";   // 更新用户信息

NSString *const CRM_notificationUpdateCRMList = @"notificationUpdateCRMList";   // 更新或新增线索
NSString *const CRM_notificationUpdateLegworkList = @"notificationUpdateLegworkList";   // 刷新外勤跟踪列表
NSString *const CRM_notificationUpdateVisitPlanList = @"notificationUpdateVisitPlanList";   // 刷新拜访记录列表

NSString *const CRM_notificationUpdateStageChange = @"notificationUpdateStageChange";   // 刷新阶段变化
NSString *const CRM_notyUpdateMissionList = @"notyUpdateMissionList";   // 刷新任务列表
NSString *const CRM_notyUpdateMissionDetail = @"notyUpdateMissionDetail";   // 刷新任务详情
NSString *const CRM_notySendMissionMessage = @"notySendMissionMessage";   // 发送任务消息

NSString *const CRM_notyUpdateVisitInfos = @"notyUpdateVisitInfos";   // 刷新拜访信息

// ccz 提示字符
NSString *const ErrorText = @"网络出错";
NSString *const LoadingText = @"加载中...";

// ccz 商城店铺
NSString *const DXDA_HttpSelectSupplier = @"/Page/ShelvesPhone/SelectSupplier.aspx";

// ccz 销售报表 HTTP
NSString *const DXDA_HttpSalesAnalyze = @"/Page/Reports/PhoneSalesAnalyze.aspx";   // 销售分析
NSString *const DXDA_HttpSalesReport = @"/Page/Reports/PhoneSalesReport.aspx";    // 销售报表
NSString *const DXDA_HttpGoodsAnalyze = @"/Page/Reports/PhoneProductAnalyze.aspx"; // 商品分析

// KPI报表
NSString *const DXDA_HttpKPIReport = @"/Page/Reports/SalesKPICheck.aspx"; // KPI报表

// ccz 消息 BI报表
NSString *const DXDA_NewsBIReport = @"/Page/Reports/BIReport.aspx";

// ccz CRM 商机报表
NSString *const CRM_OpprotunityBIReport = @"/Page/Reports/BusinessReport.aspx";

// CRM 销售漏斗
NSString *const CRM_Sale_Funnel = @"/Page/Sale/sale_funnel.aspx";

// CRM 销售活动统计
NSString *const CRM_Sales_Activities = @"/Page/Sale/SalesActivity.aspx";

//CRM 商机趋势
NSString *const CRM_Business_Trend = @"/Page/CRM/BusinessTrend.aspx?open_agent=app";

//CRM KPI报表
NSString *const CRM_Dimension = @"/Page/Dimension/DimensionReport.aspx?open_agent=app";

//知识库
NSString *const CRM_BasicData = @"/Page/BasicData/KnowledgeBaseIndex.aspx?open_agent=app";

//计划总结报表
NSString *const CRM_PlanSumReport = @"/Page/CRM/PlanSumReport.aspx?open_agent=app";

//AI报表
NSString *const CRM_AIReport = @"/Page/Dimension/AIReport.aspx?open_agent=app";

//经营分析平台
NSString *const CRM_Index = @"/Page/Index/Index.aspx?open_agent=app";

//经营分析平台
NSString *const CRM_CustDimensionReport = @"/Page/Dimension/CustDimensionReport.aspx?open_agent=app";



// ccz 权限设置开启
BOOL const OpenAuthority = NO;
//BOOL const OpenAuthority = YES;


/*============分割线==========================*/

//MARK: - 权限字段
NSString *const Authority_CustOrder = @"0202";       //订单录入
NSString *const Authority_Shipper = @"0204";         //销售发货
NSString *const Authority_CoReturn = @"0205";         //销售退货
NSString *const Authority_ShipperNotice = @"0213";         //发货通知单
NSString *const Authority_TempShipper = @"0214";         //销售暂发单
NSString *const Authority_CustomerData = @"0605";    //客户资料
NSString *const Authority_PurQuote = @"0104";     //采购报价单
NSString *const Authority_PurInquiry = @"0103";     //采购询价
NSString *const Authority_PurchaseOrder = @"0105";   //采购订单
NSString *const Authority_PurReceipt = @"0107";     //采购收货
NSString *const Authority_ReceNotice = @"0111";   // 收货通知单
NSString *const Authority_PoReturn = @"0108";     //采购退货
NSString *const Authority_PoRtnNotice = @"0125";     //采购退货通知单
NSString *const Authority_PurTempReceipt = @"0112";     //采购暂收单
NSString *const Authority_WoReceipt = @"0310";       //生产入库单
NSString *const Authority_BusinessConnection = @"0912";  //业务联系单
NSString *const Authority_Cash = @"0402";            //收款单 、预收款单
NSString *const Authority_Payment = @"0404";         //付款单 、预付款单
NSString *const Authority_ActReceivable = @"0401";   //应收账单
NSString *const Authority_ActPayable = @"0403";       //应付账单
NSString *const Authority_SalesReport = @"0801003";  //销售报表
NSString *const Authority_InvQr = @"0301";           // 其他入库单
NSString *const Authority_Issue = @"1104";           // 生产领料单
NSString *const Authority_InvQc = @"0302";           // 其他出库单
NSString *const Authority_Payout = @"04001";         //其他收付款单
NSString *const Authority_Profit = @"0304";          // 盘盈单
NSString *const Authority_Loss = @"0305";            // 盘亏单
NSString *const Authority_Material_maintain = @"0601";   // 物料维护
NSString *const Authority_Material_category = @"0602";   // 物料类别
NSString *const Authority_Unit = @"0603";   // 计量单位
NSString *const Authority_Material_warehouse = @"0604";   // 物料仓库
NSString *const Authority_Customer_infos = @"0605";       // 客户资料
NSString *const Authority_Customer_category = @"0606";    // 客户类别
NSString *const Authority_Vendor_infos = @"0607";         // 供应商资料
NSString *const Authority_Vendor_category = @"0608";      // 供应商类别
NSString *const Authority_Company_infos = @"0609";        // 企业资料
NSString *const Authority_Address_maintain = @"0610";     // 地址维护
NSString *const Authority_Emploryee_infos = @"0611";      // 员工资料
NSString *const Authority_Department_infos = @"0612";     // 部门资料
//NSString *const Authority_Material_maintain = @"613"   // 货币资料
NSString *const Authority_Tax_infos = @"0614";   // 税目明细
NSString *const Authority_Brand_infos = @"0620";  // 品牌
NSString *const Authority_Address_infos = @"0622";   // 收货地址

NSString *const Authority_M0801001 = @"0801001";  // 财务基础报表
NSString *const Authority_M0801002 = @"0801002";  // 商品分析
NSString *const Authority_M0801003 = @"0801003";  // 销售报表
NSString *const Authority_M0801004 = @"0801004";  // 销售分析

NSString *const Authority_BuyingRequisition = @"0114";   // 请购单
NSString *const Authority_CustomerContact = @"0209";   // 客户联络单
NSString *const Authority_ExpenseList = @"0409";   // 费用申请单
NSString *const Authority_ExpenseProject = @"0638";   // 费用项目
NSString *const Authority_ExpenseProject1 = @"12010"; // 费用项目1

NSString *const Authority_PGD = @"1102";   // 派工单
NSString *const Authority_Ticket = @"1103";   // 工票单
NSString *const Authority_Quote = @"0201";   // 销售报价
NSString *const Authority_Invoice = @"0212";   // 销售发票
NSString *const Authority_PurInvoice = @"0110";   // 采购发票


NSString *const Authority_Logistics = @"0221"; // 销售物流单
NSString *const Authority_PurLogistics = @"0122"; // 采购物流单
NSString *const Authority_LogisticsNotice = @"0220"; // 销售物流通知单
NSString *const Authority_PurLogisticsNotice = @"0121"; // 采购物流通知单

NSString *const Authority_Progress = @"0639";   // 进度状态
NSString *const Authority_BI = @"0801001";   // BI报表

NSString *const Authority_Listing = @"0405";   // 挂牌单
NSString *const Authority_Delisting = @"0407";   // 摘牌
NSString *const Authority_FinancialAssets = @"0702";   // 资产单
NSString *const Authority_WorkOrder = @"1101";   // 生产单

// 上架商品
NSString *const Authority_UpSelfGoods = @"0619";   // 上架商品 0619
NSString *const Authority_UnderStock = @"0546";   // 低于库存查询
NSString *const Authority_OverStock = @"0546";//= @"546";   // 高于库存查询



// 我的模块
NSString *const Authority_InviteRegister = @"0904";        // 邀请注册
NSString *const Authority_SendMessage = @"0911";        // 发送消息
NSString *const Authority_AboutUs = @"0914";        // 关于我们
NSString *const Authority_BankCard = @"0916";        // 银行卡管理
NSString *const Authority_CompanyAuthentication = @"0917";        // 企业认证

// CRM
NSString *const Authority_CRM = @"0687";            // CRM
NSString *const Authority_SaleCue = @"0641";        // 销售线索
NSString *const Authority_salesFunnel = @"17002";        // 销售漏斗
NSString *const Authority_salesActivities = @"17009";        // 销售活动统计
NSString *const Authority_Dimension = @"17030"; //kpi报表
NSString *const Authority_AIReport = @"17034"; //ai报表
NSString *const Authority_CustDimensionReport = @"171503";//客户维度报表


NSString *const Authority_clew = @"0642";           // 线索池
NSString *const Authority_highSeas = @"0643";       // 公海

NSString *const Authority_EmpOutRec = @"0646";      // 外勤
NSString *const Authority_VisitPlan = @"0647";      // 拜访计划
NSString *const Authority_VisitSum = @"0648";       // 拜访总结
NSString *const Authority_Business = @"0649";       // 商机
NSString *const Authority_CustStage = @"0650";      // 销售流程
NSString *const Authority_BusinessStage = @"0652";      // 商机阶段进度
NSString *const Authority_Opportunity = @"0653";      // 商机报表
NSString *const Authority_BusinessTrend = @"17029";   // 商机趋势
NSString *const Authority_VisitType = @"0658";      // 拜访类型
NSString *const Authority_Schedule = @"12005";     //日程
NSString *const Authority_WorkPlan = @"12004";     //工作计划
NSString *const Authority_AskVacation = @"12006";     //请假单
NSString *const Authority_SystemLog = @"0925";     //系统日志
NSString *const Authority_BasicData = @"0670";     //知识库
NSString *const Authority_PlanSumReport = @"17033";     //计划总结报表
NSString *const Authority_SWOT= @"12007";     //SWOT


NSString *const Authority_Task = @"1203";      // 任务

NSString *const PowerID_Select = @"Select";  //查看
NSString *const PowerID_Add = @"Add";        //新增
NSString *const PowerID_Update = @"Update";  //修改
NSString *const PowerID_Delete = @"Delete";  //删除
NSString *const PowerID_Appr = @"Appr";      //审批
NSString *const PowerID_Anti = @"Anti";      //反审批
NSString *const PowerID_Nextstep = @"Nextstep";      //产生下级单据
NSString *const PowerID_Print = @"Print";      //打印
NSString *const PowerID_Export = @"Export";      // 导出
NSString *const PowerID_Import = @"Import";      // 导入

NSString *const NoPower = @"无操作权限！";
NSString *const Checking = @"检查中...";


//MARK: 自动编码
NSString *const CategoryType_product_category = @"product_category";  // 物料类别
NSString *const CategoryType_vendor_category = @"vendor_category";  // 供应商类别
NSString *const CategoryType_customer_category = @"customer_category";  // 客户类别
NSString *const CategoryType_location_Info = @"location_Info";  // 物料仓库
NSString *const CategoryType_item = @"item";  // 费用项目
NSString *const CategoryType_employee = @"employee";  // 员工
NSString *const CategoryType_brand = @"brand";  // 品牌
NSString *const CategoryType_tax_id_info = @"tax_id_info";  // 税目
NSString *const CategoryType_department = @"department";  // 部门
NSString *const CategoryType_customer = @"customer";  // 客户资料
NSString *const CategoryType_vendor = @"vendor";  // 供应商资料
NSString *const CategoryType_part = @"part";  // 物料维护
NSString *const CategoryType_unit = @"unit";  // 计量单位
NSString *const CategoryType_progressStatus = @"progress_status"; // 进度状态

//MARK: 图文档
NSString *const AccessoryType_CustomerFollow = @"CUST_FL"; //客户联络单
NSString *const AccessoryType_PurchaseOrder = @"PURC_ORDER"; //采购
NSString *const AccessoryType_PurReceipt = @"PU_RECEIPT"; //采购收货
NSString *const AccessoryType_CustOrder = @"CUST_ORDER"; //销售订单
NSString *const AccessoryType_Shipper = @"SHIPPER"; //销售发货
NSString *const AccessoryType_PurInvoic = @"PUR_INVOIC"; //采购发票
NSString *const AccessoryType_Invoic = @"INVOICE"; //销售发票
NSString *const AccessoryType_Payment = @"PAYMENT";//付款单
NSString *const AccessoryType_Cash = @"CASH"; //收款单
NSString *const AccessoryType_WoReceipt =@"RECEIPT";//生产入库单
NSString *const AccessoryType_Issue =@"ISSUE";//生产领料单
NSString *const AccessoryType_WorkOrder = @"WORK_ORDER";//生产单
NSString *const AccessoryType_PoReturn =@"RCPT_RTN";//采购退货
NSString *const AccessoryType_CoReturn =@"CO_RETURN";//销售退货
NSString *const AccessoryType_CustCharge = @"CHARGE";//费用申请单
NSString *const AccessoryType_Quote = @"QUOTE";//销售报价单
NSString *const AccessoryType_PurQuote = @"PUR_QUO";//采购报价单
NSString *const AccessoryType_PUR_INQ = @"PUR_INQ"; //采购询价单
NSString *const AccessoryType_WorkPlan = @"WORK_PLAN";//工作计划
NSString *const AccessoryType_ActReceivable = @"RECEIVABLE";//应收账单
NSString *const AccessoryType_ActPayable = @"PAYABLE";//工作计划
NSString *const AccessoryType_PAYOUT = @"PAYOUT";//其他收付款单
NSString *const AccessoryType_REQUIS = @"REQUIS"; //请购单
NSString *const AccessoryType_QR = @"QR"; //其他入库单
NSString *const AccessoryType_QC = @"QC"; //其他出库单

//MARK: MethodType
// CRM
NSString *const MethodType_GetSaleCueList = @"GetSaleCueList"; // 销售线索、线索池

NSString *const MethodType_GetCustomerList = @"GetCustomerList"; // 客户列表、公海
NSString *const MethodType_OptionSaleCue = @"OptionSaleCue"; // 转换 作废 退回
NSString *const MethodType_OptionCustomer = @"OptionCustomer"; // 作废 退回
NSString *const MethodType_GetFollowRecordList = @"GetFollowRecordList"; // 跟进记录
NSString *const MethodType_GetDealingData = @"GetDealingData"; // 获取待处理总数
NSString *const MethodType_GetDealingList = @"GetDealingList"; // 获取待处理/已处理
NSString *const MethodType_OptionVisitPlan = @"OptionVisitPlan"; // 拜访计划跟换／重用
NSString *const MethodType_OptionBusiness = @"OptionBusiness"; // 商机跟换／重用
NSString *const MethodType_WorkTaskOperation = @"WorkTaskOperation"; // 操作任务
NSString *const MethodType_GetWordScheduleList = @"getWordScheduleList"; //获取日程时间列表

// CRM BI报表
// 客户总数、新增客户、拜访的客户、本期待跟进的客户、服务期内的客户、已过期的客户
//NSString *const MethodType_GetCustomerList = @"GetCustomerList";
// 新增的商机、阶段变化的商机
NSString *const MethodType_GetBusinessList = @"GetBusinessList";

// 获取待处理的商机
NSString *const MethodType_GetApproveBusinessList = @"GetApproveBusinessList";

// 线索总数、转换为商机、转换为订单、转换为客户
//NSString *const MethodType_GetSaleCueList = @"GetSaleCueList";

// Option
NSString *const CRMOptionType_TransCustomer = @"TransCustomer";  // 转换客户
NSString *const CRMOptionType_Get = @"Get";  // 领取
NSString *const CRMOptionType_Allot = @"Allot";  // 分配
NSString *const CRMOptionType_Disable = @"Disable";  // 作废
NSString *const CRMOptionType_ChangeSaleman = @"ChangeSaleman";  // 更换业务员
NSString *const CRMOptionType_ReturnCue = @"TransCustomer";  // 退回线索池
NSString *const CRMOptionType_ReturnSea = @"ReturnSea";  // 退回公海
NSString *const CRMOptionType_bindingCust = @"bindingCust";  // 绑定客户


// 外勤签到
NSString *const MethodType_GetEmpOutRecList = @"GetEmpOutRecList"; // 外勤跟踪列表
NSString *const MethodType_GetEmpOutRecAboutData = @"GetEmpOutRecAboutData"; // 外勤跟踪详情
NSString *const MethodType_AddEmpOutRec = @"AddEmpOutRec"; // 外勤签到
NSString *const MethodType_SignOut = @"SignOut"; // 外勤签退
NSString *const MethodType_DocumentUploadFile = @"DocumentUploadFile"; // 图片上传
NSString *const MethodType_GetHavePlanDay = @"GetHavePlanDay"; // 拜访计划天数
NSString *const MethodType_GetVisitPlanList = @"GetVisitPlanList"; // 拜访计划列表
NSString *const MethodType_GetDefaultSalesman = @"GetDefaultSalesman"; // 获取默认业务员


NSString *const MethodType_AddVisitPlan = @"AddVisitPlan"; // 新建拜访计划
NSString *const MethodType_UpdateVisitPlan = @"UpdateVisitPlan"; // 修改拜访计划
NSString *const MethodType_DelVisitPlan = @"DelVisitPlan"; // 删除拜访计划
NSString *const MethodType_VisitPlan = @"VisitPlan"; // 查询拜访计划
NSString *const MethodType_GetVisitSumList = @"GetVisitSumList"; // 查询拜访总结列表
NSString *const MethodType_GetCRMReport = @"GetCRMReport"; // 查询 CRM BI报表
NSString *const MethodType_UpdateBusProcess = @"UpdateBusProcess"; // 更换阶段
NSString *const MethodType_ApproveBusProcess = @"ApproveBusProcess"; // 阶段审批
NSString *const MethodType_BindingSalesman = @"BindingSalesman"; // 绑定业务员

NSString *const MethodType_SelectCusBankCard = @"SelectCusBankCard";  // 查询银行卡
NSString *const MethodType_SaveCusBankCard = @"SaveCusBankCard";  // 新增、保存银行卡
NSString *const MethodType_CertificationMyBankCard = @"CertificationMyBankCard";  // 认证银行卡

// 商城
NSString *const MethodType_ShoppingCartDeleteApp = @"ShoppingCartDeleteApp"; // 删除购物车


// 修改手机、用户名
NSString *const MethodType_SetUserInfoApp = @"SetUserInfoApp"; // 修改手机、用户名
NSString *const MethodType_SetUserPassWord = @"SetUserPassWord"; // 修改密码

NSString *const MethodType_DeleteBrandForList = @"DeleteBrandForList"; // 删除品牌

NSString *const MethodType_GetAppBanner = @"GetAppBanner"; // 获取banner

NSString *const MethodType_GetAppBannerList = @"GetAppBannerList"; // 获取bannerlist

// 工作台 key
NSString *const MethodType_UpdateUserConfig = @"UpdateUserConfig";  // 更新工作台
NSString *const MethodType_SelectUserConfig = @"SelectUserConfig";  // 查询工作台
NSString *const MethodType_InitWorkPlatformModuleInfo = @"InitWorkPlatformModuleInfo";  // 查询工作台其他模块
NSString *const MethodType_SaveWorkPlatformModuleInfo = @"SaveWorkPlatformModuleInfo";  // 编辑工作台其他模块

NSString *const workCenterKey = @"dxda_workCenter_identy";

/*
 RpType CRM BI报表 类型
 */
NSString *const RpType_CustZB = @"CustZB"; // 销售指标
NSString *const RpType_CustRp = @"CustRp"; // 销售简报
NSString *const RpType_OrderJY = @"OrderJY"; // 交易订单
NSString *const RpType_SC = @"SC"; // 线索转换

/*
 BIType CRM BI报表 穿透类型
 */
NSString *const BIType_CustAllQty = @"CustAllQty";          // 客户总数
NSString *const BIType_addCustQty = @"addCustQty";          // 新增客户
NSString *const BIType_vistCustQty = @"vistCustQty";        // 拜访的客户
NSString *const BIType_stayCustQty = @"stayCustQty";        // 本期待跟进的客户
NSString *const BIType_serverCustQty = @"serverCustQty";    // 服务期内的客户
NSString *const BIType_outedCustQty = @"outedCustQty";      // 已过期的客户
NSString *const BIType_addSaleRecordQty = @"addSaleRecordQty";      // 新增的销售记录
NSString *const BIType_addBusinessQty = @"addBusinessQty";  // 新增的商机
NSString *const BIType_stageChangeQty = @"stageChangeQty";  // 阶段变化的商机
NSString *const BIType_saleCueQty = @"saleCueQty";          // 线索总数
NSString *const BIType_transBusiness = @"transBusiness";    // 转换为商机
NSString *const BIType_transCustomer = @"transCustomer";    // 转换为客户
NSString *const BIType_transCustOrder = @"transCustOrder";  // 转换为订单


//MARK: - IM 扩展消息
NSString *const IM_sendUserNike = @"send_message_dxda_user_nike";  // 发送昵称
NSString *const IM_sendUserId = @"send_message_dxda_user_id";  // 发送ID
NSString *const IM_sendUserHead = @"send_message_dxda_user_head";  // 发送头像
NSString *const IM_recvUserNike = @"recv_message_dxda_user_nike";  // 接收昵称
NSString *const IM_recvUserId = @"recv_message_dxda_user_id";  // 接收ID
NSString *const IM_recvUserHead = @"recv_message_dxda_user_head";  // 接收头像

NSString *const IM_Legwork_data = @"dxda_task_bean_json";  // 任务数据
NSString *const IM_crm_task_type = @"message_crm_task_type";  // 是否是任务消息 BOOL

@implementation DXDAExternStaticString

@end
