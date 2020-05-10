//
//  NSObject+BoolType.h
//  x_App
//
//  Created by DXDA on 2017/5/25.
//  Copyright © 2017年 SimpleTable. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DXDANewsDetailModel;

@interface NSObject (BoolType)

//MARK: - 判断单据类型 创建模型 纯消息类展示 或者 单据类展示
+(BOOL)judgeModelType:(DXDANewsDetailModel *)model;

//MARK: - 判断 收付款类型
+(BOOL)judgePaymentModel:(DXDANewsDetailModel *)model;

//MARK: - 判断 收发货类型
+(BOOL)judgeConsigneeModel:(DXDANewsDetailModel *)model;

//MARK: - 判断 开放的类型
+(BOOL)judgeOrderType:(DXDANewsDetailModel *)model;

//MARK: - 判断 是否显示总金额 (销售、采购 物流单 、物流通知单 默认隐藏)
+(BOOL)judgeAmountHidden:(DXDANewsDetailModel *)model;

#pragma mark - 返回 push 类型
+(NSString *)returnPushType:(DXDANewsDetailModel *)model;

#pragma mark - 返回 收付款 预收预付款 cash_type payment_type 类型
+(NSString *)returnCash_payment_type:(DXDANewsDetailModel *)model;

#pragma mark - 返回真正fromOrderType
+(NSString *)returnTrueOrderType:(DXDANewsDetailModel *)model;

#pragma mark - 消息类型 - title New
+(NSString *)returnOrderTitleName:(DXDANewsDetailModel *)model;

#pragma mark - 详情 title New
+(NSString *)returnControllerTitleName:(DXDANewsDetailModel *)model;

#pragma mark - 返回单据状态
+(NSString *)returnCurrentStatus:(NSInteger)status;

@end
