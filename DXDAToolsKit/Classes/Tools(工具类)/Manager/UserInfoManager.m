//
//  UserInfoManager.m
//  RxdaApp
//
//  Created by Erowin on 16/9/9.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "UserInfoManager.h"
#import "NSString+path.h"

@implementation UserInfoManager

static UserInfoManager *manager = nil;

+(instancetype)sharedUserInfoManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc]init];
        manager.userData = [manager readUserdata];
    
    });
    return manager;
}

-(void)saveDocumentsWithImage:(UIImage *)image
{
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    self.userData.icon_Data = data;
    [[UserInfoManager sharedUserInfoManager] saveUserInfoWithData:self.userData];
}

-(void)saveUserInfoWithData:(UserInfoModel *)data
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSKeyedArchiver archiveRootObject:data toFile:[NSString userDataPathWithFileName:@"userData.plist"]];
    });
}
-(UserInfoModel *)readUserdata
{
    UserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString userDataPathWithFileName:@"userData.plist"]];
//    if (model.strUserID==nil||model.strUserPWD==nil)
//    {
//        [UIApplication sharedApplication].keyWindow.rootViewController = []
//    }
    return model;
}

-(void)setUserData:(UserInfoModel *)userData
{
    _userData = userData;
}

/**
 *  保存其他信息
 */
-(void)saveOtherInfoWithData:(OtherInfoModel *)data
{
    
    NSMutableArray *datas = [NSMutableArray arrayWithArray:[self readOtherDatas]];
    
    for (OtherInfoModel *model in datas)
    {
        if ([model.strUserID isEqualToString:data.strUserID])
        {
            model.gesture = data.gesture;
            model.isOpenGesture = data.isOpenGesture;
            [NSKeyedArchiver archiveRootObject:datas toFile:[NSString userDataPathWithFileName:@"otherData.data"]];
            return;
        }
    }
    [datas addObject:data];
    [NSKeyedArchiver archiveRootObject:datas toFile:[NSString userDataPathWithFileName:@"otherData.data"]];
}

-(OtherInfoModel *)readOtherdata
{
    NSMutableArray *datas = [NSMutableArray arrayWithArray:[self readOtherDatas]];
    
    for (OtherInfoModel *model in datas)
    {
        if ([model.strUserID isEqualToString:self.userData.strUserID])
        {
            return model;
        }
    }
    OtherInfoModel *model = [[OtherInfoModel alloc]init];
    model.strUserID = self.userData.strUserID;
    return model;
}
/**
 * 刷新其他信息
 */
-(NSArray *)readOtherDatas
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString userDataPathWithFileName:@"otherData.data"]];
}

@end
