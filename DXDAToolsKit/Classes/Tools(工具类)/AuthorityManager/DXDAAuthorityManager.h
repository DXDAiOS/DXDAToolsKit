//
//  DXDAAuthorityManager.h
//  x_App
//
//  Created by DXDA on 2017/6/13.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AuthorityType) {
    authoritySelectType = 0, // 查
    authorityDeleteType,     // 删
    authorityAddType,        // 增
    authorityUpdateType,     // 改
    authorityApproveType,    // 审批
    authorityDisApproveType, // 反审批
    authorityNextstep,       // 产生下级单据
    authorityPrint,          // 打印
    authorityExport,         // 导出
    authorityImport,         // 导入
};

@interface DXDAAuthorityManager : NSObject

+ (void)clearAuthorityData;


#pragma mark - 判断是否有权限

/**
 判断是否有权限

 @param type 具有哪种权限
 @param authority_id 对应权限id
 @param open 默认 NO ，YES 打开该权限
 @param success 0 有权限
 @param fail 1 无权限
 @param errorBlock 网络访问出错
 */
+ (void)judgeAuthorityType:(AuthorityType)type
             authority_id:(NSString *)authority_id
              defaultOpen:(BOOL)open
                  success:(void(^)(BOOL flag))success
                     fail:(void(^)(NSString *message))fail
                    error:(void(^)(NSString *message))errorBlock;

@property (nonatomic,assign) AuthorityType authorityType;

// 根据原代码，加需求返回VCTitle
+ (NSString *)returnCurrentClassTitle:(NSString *)orderType;

+ (NSString *)returnCurrentAuthority_id:(NSString *)classTitle;

@end
