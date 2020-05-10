//
//  GetUserAuthority.m
//  x_App
//
//  Created by DXDA on 2018/1/8.
//  Copyright © 2018年 SimpleTable. All rights reserved.
//

#import "GetUserAuthority.h"

static NSString *const photoSettingString = @"当前相册权限没有开启，是否前往设置";
static NSString *const cameraSettingString = @"当前相机权限没有开启，是否前往设置";
static NSString *const addressBookSettingString = @"当前通讯录权限没有开启，是否前往设置";

@implementation GetUserAuthority

//MARK: - 获取权限
+ (void)getUserAuthorizationWith:(UserAuthorizationType)type allow:(void(^)(void))allow otherState:(void(^)(void))state {
    switch (type) {
        case UserAuthorizationType_photo:
        {
            [self getPhotoAuthority:^{
                !allow ? : allow();
            } otherState:^(PHAuthorizationStatus status) {
                !state ? : state();
            }];
        }
            break;
        case UserAuthorizationType_camera:
        {
            [self getCameraAuthority:^{
                !allow ? : allow();
            } otherState:^(AVAuthorizationStatus status) {
                !state ? : state();
            }];
        }
            break;
        case UserAuthorizationType_addressBook:
        {
            [self getAddressBookAuthority:^{
                !allow ? : allow();
            } otherState:^(ABAuthorizationStatus status) {
                !state ? : state();
            }];
        }
            break;
            
        default:
            break;
    }
}


//MARK: - 获取相册权限
+ (void)getPhotoAuthority:(void(^)(void))allow otherState:(void(^)(PHAuthorizationStatus status))state {
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthStatus) {
        case PHAuthorizationStatusNotDetermined:
            NSLog(@"未询问用户是否授权");
        {
            [self requestAuthorization:UserAuthorizationType_photo agreeHandle:^{
                !allow ? : allow();
            } refuseHandle:nil];
        }
            break;
        case PHAuthorizationStatusRestricted:
            NSLog(@"未授权，例如家长控制");
        {
            [self showAlertToSettingWith:photoSettingString setting:nil];
            !state ? : state(PHAuthorizationStatusRestricted);
        }
            break;
        case PHAuthorizationStatusDenied:
            NSLog(@"未授权，用户拒绝造成的");
        {
            [self showAlertToSettingWith:photoSettingString setting:nil];
            !state ? : state(PHAuthorizationStatusDenied);
        }
            break;
        case PHAuthorizationStatusAuthorized:
            NSLog(@"同意授权相册");
            !allow ? : allow();
            break;
        default:
        {
            [self showAlertToSettingWith:photoSettingString setting:nil];
            !state ? : state(photoAuthStatus);
        }
            break;
    }
    
    

}

//MARK: - 获取相机权限
+ (void)getCameraAuthority:(void(^)(void))allow otherState:(void(^)(AVAuthorizationStatus status))state {
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (videoAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
            NSLog(@"未询问用户是否授权");
        {
            [self requestAuthorization:UserAuthorizationType_camera agreeHandle:^{
                !allow ? : allow();
            } refuseHandle:nil];
        }
//            !state ? : state(AVAuthorizationStatusNotDetermined);
            break;
        case AVAuthorizationStatusRestricted:
            NSLog(@"未授权，例如家长控制");
        {
            [self showAlertToSettingWith:cameraSettingString setting:nil];
            !state ? : state(videoAuthStatus);
        }
            
            break;
        case AVAuthorizationStatusDenied:
            NSLog(@"未授权，用户拒绝造成的");
        {
            [self showAlertToSettingWith:cameraSettingString setting:nil];
            !state ? : state(videoAuthStatus);
        }
            
            break;
        case AVAuthorizationStatusAuthorized:
            NSLog(@"同意授权相机");
            !allow ? : allow();
            break;
        default:
        {
            [self showAlertToSettingWith:cameraSettingString setting:nil];
            !state ? : state(videoAuthStatus);
        }
            break;
    }
}

//MARK: - 获取通讯录权限
+ (void)getAddressBookAuthority:(void(^)(void))allow otherState:(void(^)(ABAuthorizationStatus status))state {
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    switch (authorizationStatus) {
        case  kABAuthorizationStatusNotDetermined:
            NSLog(@"未询问用户是否授权");
        {
            [self requestAuthorization:UserAuthorizationType_addressBook agreeHandle:^{
                !allow ? : allow();
            } refuseHandle:nil];
        }
//            !state ? : state(kABAuthorizationStatusNotDetermined);
            break;
        case kABAuthorizationStatusRestricted:
            NSLog(@"未授权，例如家长控制");
        {
            [self showAlertToSettingWith:addressBookSettingString setting:nil];
            !state ? : state(authorizationStatus);
        }
            break;
        case kABAuthorizationStatusDenied:
            NSLog(@"未授权，用户拒绝造成的");
        {
            [self showAlertToSettingWith:addressBookSettingString setting:nil];
            !state ? : state(authorizationStatus);
        }
            break;
        case kABAuthorizationStatusAuthorized:
            NSLog(@"同意授权通讯录");
            !allow ? : allow();
            break;
        default:
        {
            [self showAlertToSettingWith:addressBookSettingString setting:nil];
            !state ? : state(authorizationStatus);
        }
            break;
    }

}


//MARK: - 请求权限
+ (void)requestAuthorization:(UserAuthorizationType)userType agreeHandle:(void(^)(void))agree refuseHandle:(void(^)(void))refuse {
    
    switch (userType) {
        case UserAuthorizationType_photo:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    NSLog(@"用户同意授权相册");
                    !agree ? : agree();
                }else {
                    NSLog(@"用户拒绝授权相册");
                    !refuse ? : refuse();
                }
            }];
        }
            break;
        case UserAuthorizationType_camera:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted){
                    NSLog(@"用户同意授权相机");
                    !agree ? : agree();
                }else {
                    NSLog(@"用户拒绝授权相机");
                    !refuse ? : refuse();
                }
                
            }];
        }
            break;
        case UserAuthorizationType_addressBook:
        {
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    NSLog(@"用户同意授权通讯录");
                    !agree ? : agree();
                    CFRelease(addressBook);
                } else {
                    NSLog(@"用户拒绝授权通讯录");
                    !refuse ? : refuse();
                }
            });
        }
            break;
            
        default:
            break;
    }    
}

//MARK: - 是否前往设置
+ (void)showAlertToSettingWith:(NSString *)message setting:(void(^)(void))setting {
    UIWindow *tempWindow = [UIApplication sharedApplication].keyWindow;

//    NSLog(@"test controller:%@",tempWindow.rootViewController);
    
    NSString *tempMessage = message ? : @"是否前往设置";
    
    UIViewController *controller = [self returnViewController:tempWindow.rootViewController];
    
    [self showWithMessage:tempMessage controller:controller setting:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        !setting ? : setting();
    }];
}

+ (void)showWithMessage:(NSString *)message controller:(UIViewController *)controller setting:(void(^)(void))setting {
    [controller showAlertMessage:message Actions:@[@"取消",@"前往"] completion:^(NSInteger index) {
        if (index == 1) {
            !setting ? : setting();
        }
    }];
}

+ (UIViewController *)returnViewController:(id)obj {
    if ([obj isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)obj;
        UIViewController *currentVC = tabVC.viewControllers[tabVC.selectedIndex];

        if ([currentVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *naVC = (UINavigationController *)currentVC;
            UIViewController *controller = naVC.viewControllers.lastObject;
            return controller;
        }
        else if ([currentVC isKindOfClass:[UITabBarController class]]) {
            return [self returnViewController:currentVC];
        }
        else if ([currentVC isMemberOfClass:[UIViewController class]]) {
            return currentVC;
        }
        else {
            return obj;
        }
    }
    else if ([obj isKindOfClass:[UINavigationController class]]) {
        UINavigationController *naVC = (UINavigationController *)obj;
        UIViewController *controller = naVC.viewControllers.lastObject;
        return controller;
    }
    else {
        return obj;
    }
}

@end
