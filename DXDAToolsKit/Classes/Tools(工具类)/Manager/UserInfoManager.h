//
//  UserInfoManager.h
//  RxdaApp
//
//  Created by Erowin on 16/9/9.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
#import "OtherInfoModel.h"

@interface UserInfoManager : NSObject
/**
 *  提供单例
 */
+(instancetype)sharedUserInfoManager;
/**
 *  用户数据
 */
@property(nonatomic,strong)UserInfoModel *userData;
/**
 *  保存用户信息
 */
-(void)saveUserInfoWithData:(UserInfoModel *)data;
/**
 * 刷新用户信息
 */
-(UserInfoModel *)readUserdata;
/**
 *  保存用户头像
 */
-(void)saveDocumentsWithImage:(UIImage *)image;
/**
 *  保存其他信息
 */
-(void)saveOtherInfoWithData:(OtherInfoModel *)data;
/**
 * 刷新其他信息
 */
-(OtherInfoModel *)readOtherdata;

-(NSArray *)readOtherDatas;

@end
