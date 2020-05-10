//
//  UIViewController+DXDAAlterViewController.h
//  x_App
//
//  Created by DXDA on 2017/6/8.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DXDAAlterViewController)<UIAlertViewDelegate,UIActionSheetDelegate>

//弹出alert
-(void)showAlertMessage:(NSString *)message oneText:(NSString *)one twoText:(NSString *)two completion:(void(^)(NSInteger index))completion;

-(void)showAlertWithTitle:(NSString *)title Message:(NSString *)message oneText:(NSString *)one twoText:(NSString *)two completion:(void(^)(NSInteger index))completion;

//弹出alertSheet
-(void)showActionSheet:(NSString *)one twoText:(NSString *)two completion:(void(^)(NSInteger index))completion;

-(void)showActionSheets:(NSArray *)array completion:(void(^)(NSInteger index))completion;


//弹出alert
-(void)showAlertMessage:(NSString *)message Actions:(NSArray *)Actions completion:(void(^)(NSInteger index))completion;

//输入批号序列号
-(void)showAlertTextFieldMessage:(NSString *)message Actions:(NSArray *)Actions text:(NSString *)text completion:(void(^)(NSInteger index,NSString *text))completion;

@end
