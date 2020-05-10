//
//  DXDAFMDBListOcManager.m
//  NewApp3.0
//
//  Created by DXDA on 2018/7/5.
//  Copyright © 2018年 DXDA. All rights reserved.
//

#import "DXDAFMDBListOcManager.h"

NSString *userDBList = @"DLuserListDB";

@implementation DXDAFMDBListOcManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.XFMDB = [[DXDAFMDBManager alloc] init];
        
        //账号区 Chn_Addr
        //账号省 State
        //账号市 City
        //用户ID User_ID
        //邮编 Zip_Code
        //公司头像 Company_Icon
        //公司logo Company_Logo
        //用户密码 User_PWD
        //企业名称 Company_Name
        //用户名 User_Name
        //管理员名称 Link_Man
        
        _userDBListkey = @[@[@"userid",@"userpassword",@"Chn_Addr",@"State",@"City",@"Zip_Code",@"Company_Icon",@"Company_Logo",@"Company_Name",@"Link_Man",@"User_Name",@"mobUserID",@"loginTime"],
             @[@"text",@"text",@"text",@"text",@"text",@"text",@"text",@"text",@"text",@"text",@"text",@"text",@"text"],@[@"id",@"userid",@"userpassword",@"Chn_Addr",@"State",@"City",@"Zip_Code",@"Company_Icon",@"Company_Logo",@"Company_Name",@"Link_Man",@"User_Name",@"mobUserID",@"loginTime"]];
    }
    return self;
}

- (void)userListWriteData:(UserInfoModel *)model
{
    // 删除测试数据表
    if ([self.XFMDB xfSelectFromTableWithTableName:@"userDBList" arFieldsKey:@[@"id"]]) {
        [self.XFMDB xfDropTableWithTableName:@"userDBList"];
    }
    [self.XFMDB xfCreateTableWithTableName:userDBList arFields:_userDBListkey[0] arFieldsType:_userDBListkey[1]];
    NSArray *arr = [self.XFMDB xfSelectFromTableWithTableName:userDBList arFieldsKey:@[@"userid"]];
    if (arr.count>0) {
        NSArray *keyArr = [arr valueForKey:@"userid"];
        if ([keyArr containsObject:model.User_ID]) {
            BOOL save = [self.XFMDB xfModifyToDataWithTableName:userDBList dicFields:@{@"userpassword":model.User_PWD,
                                                                                       @"Chn_Addr":model.Chn_Addr,
                                                                                       @"State":model.State,
                                                                                       @"City":model.City,
                                                                                       @"Zip_Code":model.Zip_Code,
                                                                                       @"Company_Icon":model.Company_Icon,
                                                                                       @"Company_Logo":model.Company_Logo,
                                                                                       @"Company_Name":model.Company_Name,
                                                                                       @"Link_Man":model.Link_Man,
                                                                                       @"User_Name":model.User_Name,
                                                                                       @"mobUserID":model.mobUserID ? : @"",
                                                                                       @"loginTime":model.loginTime
                                                                                       } ConditionsKey:@"userid" ConditionsValue:model.User_ID];
            NSLog(@"%@",save?@"修改成功":@"修改失败");
        }
        else
        {
            [self.XFMDB xfInsertDataToTableWithTableName:userDBList dicFields:@{@"userid":model.User_ID,
                                                                                @"userpassword":model.User_PWD,
                                                                                @"Chn_Addr":model.Chn_Addr,
                                                                                @"State":model.State,
                                                                                @"City":model.City,
                                                                                @"Zip_Code":model.Zip_Code,
                                                                                @"Company_Icon":model.Company_Icon,
                                                                                @"Company_Logo":model.Company_Logo,
                                                                                @"Company_Name":model.Company_Name,
                                                                                @"Link_Man":model.Link_Man,
                                                                                @"User_Name":model.User_Name,
                                                                                @"mobUserID":model.mobUserID ? : @"",
                                                                                @"loginTime":model.loginTime
                                                                                }];
        }
    }
    else
    {
        [self.XFMDB xfInsertDataToTableWithTableName:userDBList dicFields:@{@"userid":model.User_ID,
                                                                            @"userpassword":model.User_PWD,
                                                                            @"Chn_Addr":model.Chn_Addr,
                                                                            @"State":model.State,
                                                                            @"City":model.City,
                                                                            @"Zip_Code":model.Zip_Code,
                                                                            @"Company_Icon":model.Company_Icon,
                                                                            @"Company_Logo":model.Company_Logo,
                                                                            @"Company_Name":model.Company_Name,
                                                                            @"Link_Man":model.Link_Man,
                                                                            @"User_Name":model.User_Name,
                                                                            @"mobUserID":model.mobUserID ? : @"",
                                                                            @"loginTime":model.loginTime
                                                                            }];
    }


}


@end
