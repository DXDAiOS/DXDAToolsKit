//
//  DXDAFMDBSearchHistoryManager.h
//  NewApp3.0
//
//  Created by DXDA on 2019/4/2.
//  Copyright © 2019 DXDA. All rights reserved.
//

extern NSString * _Nonnull historyList;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DXDAFMDBSearchHistoryManager : NSObject
@property (nonatomic, strong) DXDAFMDBManager *XFMDB;
@property (nonatomic, strong) NSArray *userDBListkey;
// 写入账户密码
- (void)userListWriteData:(NSString *)orderType searchText:(NSString *)searchText;
// 删除表格
-(void)deleteAction:(NSString *)orderType;

@end

NS_ASSUME_NONNULL_END
