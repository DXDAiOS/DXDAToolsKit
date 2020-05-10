//
//  DXDASingleton.h
//  NewApp3.0
//
//  Created by DXDA on 2017/3/28.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DXDAArticleInfoModel;   // hk

@interface DXDASingleton : NSObject

@property (nonatomic,assign) BOOL hide;   // 判断是否隐藏单价

/*
 查看详情 NO  新增为 YES
 */
@property (nonatomic,assign) BOOL judgeRemark;  // 判断用remark or line_remark

@property (nonatomic,assign) BOOL isInventory;    // 盘盈、盘亏单跳转

@property (nonatomic,assign) BOOL isExpense;    // 根据 是否 费用申请单 显示相应字段

@property (nonatomic,assign) BOOL isTicket;    // 根据 是否 工票单 显示相应字段

@property (nonatomic,assign) BOOL isRequisition;    // 根据 是否 请购单 显示相应字段

@property (nonatomic,assign) BOOL isNotCRM; //用来区分进销存-销售报价单
@property (nonatomic,assign) BOOL isQuote;    // 根据 是否 销售、采购报价单 显示相应字段

@property (nonatomic,assign) BOOL isInvoice;    // 根据 是否 销售、采购发票单 显示相应字段

@property (nonatomic,assign) BOOL isLogistics;    // 根据 是否 物流 显示相应字段

@property (nonatomic,assign) BOOL isProductionStorage;    // 根据 是否 出入库单 显示相应字段

@property (nonatomic,assign) BOOL isReceiveNotice;    // 根据 是否 收发货通知单 显示相应字段

@property (nonatomic,assign) BOOL isWorkOrder;    // 根据 是否 生产单 显示相应字段

@property (nonatomic,assign) BOOL isPayout;    // 根据 是否 其他收付款 显示相应字段

@property (nonatomic,assign) BOOL inQuiry;    //根据 是否 采购询价单 显示相应字段

@property (nonatomic,assign) BOOL isPGD;    //根据 是否 采购询价单 显示相应字段

@property (nonatomic,assign) BOOL isIssue;   //生产领料单

@property (nonatomic,copy) NSArray<DXDAArticleInfoModel *> *hk_ArticleArray;  // 针对华凯的数组

@property (nonatomic,strong) DXDAArticleInfoModel *currentModel;  // 当前模型

@property (nonatomic,assign) BOOL isCust_PurchaseType; // 判断单据类型，如果是销售、采购单 单价不能改高

@property (nonatomic,assign) BOOL isShowHistoryView;   // 新增的时候隐藏消息历史

+(instancetype)share;

@property (nonatomic,weak) UIViewController *tempVC;   // 测试用属性

@property (nonatomic,copy) NSString *trans_no; // 测试用属性

//-------------------------------------------------------------------
@property (nonatomic,assign) NSInteger requestIndex;

@property (nonatomic,strong) NSMutableDictionary *requestDic;

@property (nonatomic,copy) NSString *currentTitle;

@property (nonatomic,assign) NSInteger chooseState;

@property (nonatomic,copy) NSString *companyName;  // 传递当前消息公司名

@property (nonatomic,assign) BOOL notCheck;   // 单据是否已查看
@end
