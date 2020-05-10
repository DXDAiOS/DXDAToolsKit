//
//  GetUserAuthority.h
//  x_App
//
//  Created by DXDA on 2018/1/8.
//  Copyright © 2018年 SimpleTable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>
#ifdef NSFoundationVersionNumber_iOS_8_x_Max
#import <Contacts/Contacts.h>
#endif


typedef NS_ENUM(NSInteger, UserAuthorizationType) {
    UserAuthorizationType_photo,
    UserAuthorizationType_camera,
    UserAuthorizationType_addressBook,
};

@interface GetUserAuthority : NSObject

//MARK: - 获取权限
+ (void)getUserAuthorizationWith:(UserAuthorizationType)type allow:(void(^)(void))allow otherState:(void(^)(void))state;

//MARK: - 获取相册权限
+ (void)getPhotoAuthority:(void(^)(void))allow otherState:(void(^)(PHAuthorizationStatus status))state;

//MARK: - 获取相机权限
+ (void)getCameraAuthority:(void(^)(void))allow otherState:(void(^)(AVAuthorizationStatus status))state;

//MARK: - 获取通讯录权限
+ (void)getAddressBookAuthority:(void(^)(void))allow otherState:(void(^)(ABAuthorizationStatus status))state;

//MARK: - 请求权限
+ (void)requestAuthorization:(UserAuthorizationType)userType agreeHandle:(void(^)(void))agree refuseHandle:(void(^)(void))refuse;

//MARK: - 是否前往设置
+ (void)showAlertToSettingWith:(NSString *)message setting:(void(^)(void))setting;

@end
