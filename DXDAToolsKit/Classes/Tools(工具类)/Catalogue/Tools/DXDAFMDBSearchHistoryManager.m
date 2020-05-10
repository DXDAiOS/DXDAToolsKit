//
//  DXDAFMDBSearchHistoryManager.m
//  NewApp3.0
//
//  Created by DXDA on 2019/4/2.
//  Copyright © 2019 DXDA. All rights reserved.
//


#import "DXDAFMDBSearchHistoryManager.h"

NSString *historyList = @"historyList";

@implementation DXDAFMDBSearchHistoryManager

- (instancetype)init
{
    if (self = [super init]) {
        self.XFMDB = [[DXDAFMDBManager alloc] init];
        _userDBListkey = @[
                           @[@"searchText"],
                           @[@"text"],
                           ];
    }
    return self;
}

- (void)userListWriteData:(NSString *)orderType searchText:(NSString *)searchText
{
    [self.XFMDB xfCreateTableWithTableName:orderType arFields:_userDBListkey[0] arFieldsType:_userDBListkey[1]];
    NSArray *arr = [self.XFMDB xfSelectFromTableWithTableName:orderType arFieldsKey:@[@"searchText"]];
    
    if (arr.count > 0) {
        NSArray *keyArr = [arr valueForKey:@"searchText"];
        if ([keyArr containsObject:searchText]) {
            [self.XFMDB xfDeleteFromTableWithTableName:orderType FieldKey:@"searchText" FieldValue:searchText];
            
            [self.XFMDB xfInsertDataToTableWithTableName:orderType dicFields:@{@"searchText":searchText}];
            
        }else{
            [self.XFMDB xfInsertDataToTableWithTableName:orderType dicFields:@{@"searchText":searchText}];
        }
        
        
    }else{
        [self.XFMDB xfInsertDataToTableWithTableName:orderType dicFields:@{@"searchText":searchText}];
    }

}

-(void)deleteAction:(NSString *)orderType
{
    [self.XFMDB xfDropTableWithTableName:orderType];
}

@end
