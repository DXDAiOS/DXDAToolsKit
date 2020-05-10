//
//  UIResponder+DXDASelfManager.m
//  x_App
//
//  Created by DXDA on 2017/6/2.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UIResponder+DXDASelfManager.h"

@implementation UIResponder (DXDASelfManager)


+(UIViewController *)returnController {
    
    UIViewController *controller = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarC = (UITabBarController *)controller;
        UINavigationController *navigationC = tabbarC.selectedViewController;
        return navigationC.viewControllers.lastObject;
    }else if ([controller isKindOfClass:[UINavigationController class]]){
        
        UINavigationController *navigationC = (UINavigationController *)controller;
        return navigationC.viewControllers.lastObject;
    }
    return controller;
//    UITabBarController *tabbarC = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//    UINavigationController *navigationC = tabbarC.selectedViewController;
//    return navigationC.viewControllers.lastObject;
}


@end
