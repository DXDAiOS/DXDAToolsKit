//
//  DXDAFMDBListOcManager.h
//  NewApp3.0
//
//  Created by DXDA on 2018/7/5.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *userDBList;

@interface DXDAFMDBListOcManager : NSObject

@property (nonatomic, strong) DXDAFMDBManager *XFMDB;

@property (nonatomic, strong) NSArray *userDBListkey;

// 写入账户密码
- (void)userListWriteData:(UserInfoModel *)model;

@end
