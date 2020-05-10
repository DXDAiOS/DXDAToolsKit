//
//  UIViewController+DXDAAlterViewController.m
//  x_App
//
//  Created by DXDA on 2017/6/8.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import "UIViewController+DXDAAlterViewController.h"
#import <objc/runtime.h>
#import "DXDANormalTools.h"

static const char * alertKey = "alertKey";

@implementation UIViewController (DXDAAlterViewController)


-(void)showAlertMessage:(NSString *)message Actions:(NSArray *)Actions completion:(void(^)(NSInteger index))completion
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i = 0 ; i<Actions.count ; i++) {
        UIAlertAction * alertA = [UIAlertAction actionWithTitle:Actions[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(i) : nil;
        }];
        [alertController addAction:alertA];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

-(void)showAlertTextFieldMessage:(NSString *)message Actions:(NSArray *)Actions text:(NSString *)text completion:(void(^)(NSInteger index,NSString *text))completion
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = text;
        textField.placeholder = [NSString stringWithFormat:@"%@",message];
    }];
    UITextField * tf = alertController.textFields[0];
    
    for (int i = 0 ; i<Actions.count ; i++) {
        UIAlertAction * alertA = [UIAlertAction actionWithTitle:Actions[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(i,tf.text) : nil;
        }];
        [alertController addAction:alertA];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

/**
 * 分割线---------------------------------------------------------------------------------
 */
#pragma mark - showAlertView
- (void)showAlertView:(NSString *)message cancelText:(NSString *)cancel otherText:(NSString *)other completion:(void (^) (NSUInteger index))completion
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:other, nil];
    [alertView show];
    
#pragma mark - runtime AssociatedObject 设置关联
        void (^block)(NSInteger) = ^(NSInteger index) {
            completion ? completion(index) : nil;
        };
        objc_setAssociatedObject(alertView, &alertKey, block, OBJC_ASSOCIATION_COPY);
}


#pragma mark - alertView delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        void (^block)(NSInteger) = objc_getAssociatedObject(alertView, &alertKey);
        block(buttonIndex);
//    _alertBlock(buttonIndex);
}

#pragma mark - showAlertActionSheet
-(void)showAlertActionSheet:(NSString *)one twoText:(NSString *)two completion:(void (^) (NSUInteger index))completion
{
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:one,two, nil];
    [sheet showInView:self.view];
    
    void (^block)(NSInteger) = ^(NSInteger index) {
        completion ? completion(index) : nil;
    };
    objc_setAssociatedObject(sheet, &alertKey, block, OBJC_ASSOCIATION_COPY);
//    self.alertBlock = ^(NSInteger index) {
//        completion ? completion(index) : nil;
//    };
}

#pragma mark - showAlertActionSheets
-(void)showAlertActionSheets:(NSArray *)array completion:(void (^) (NSUInteger index))completion
{
    UIActionSheet * sheet = [[UIActionSheet alloc] init];
    sheet.delegate = self;
    for (int i=0; i<=array.count; i++) {
        i == array.count ? [sheet addButtonWithTitle:@"取消"] : [sheet addButtonWithTitle:array[i]];
    }
    sheet.cancelButtonIndex = array.count;
    [sheet showInView:self.view];
    
    void (^block)(NSInteger) = ^(NSInteger index) {
        completion ? completion(index) : nil;
    };
    objc_setAssociatedObject(sheet, &alertKey, block, OBJC_ASSOCIATION_COPY);
//    self.alertBlock = ^(NSInteger index) {
//        completion ? completion(index) : nil;
//    };
}

#pragma mark - showAlertActionSheet delegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        void (^block)(NSInteger) = objc_getAssociatedObject(actionSheet, &alertKey);
        block(buttonIndex);
//    _alertBlock(buttonIndex);
}

/**
 * alertController
 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#pragma mark - AlertController method
-(void)showAlertController:(UIAlertControllerStyle)style
                     title:(NSString *)title
                   message:(NSString *)message
                   oneText:(NSString *)one
                   twoText:(NSString *)two
                completion:(void (^) (NSInteger index))completion
{
    if (title == nil) {
        title = @"温馨提示";
    }
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    if (one) {
        UIAlertAction * alertA = [UIAlertAction actionWithTitle:one style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(0) : nil;
        }];
        [alertController addAction:alertA];
    }
    
    if (two) {
        UIAlertAction * alertB = [UIAlertAction actionWithTitle:two style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(1) : nil;
        }];
        [alertController addAction:alertB];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
//    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showAlertControllerStyleSheet:(NSString *)one
                             twoText:(NSString *)two
                          completion:(void (^) (NSInteger index))completion
{
    UIAlertController * alertController = [UIAlertController new];
    
    if (one) {
        UIAlertAction * alertA = [UIAlertAction actionWithTitle:one style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(0) : nil;
        }];
        [alertController addAction:alertA];
    }
    
    if (two) {
        UIAlertAction * alertB = [UIAlertAction actionWithTitle:two style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(1) : nil;
        }];
        [alertController addAction:alertB];
    }
    UIAlertAction * alertC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertC];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
//    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - more sheet
-(void)showAlertControllerStyleSheets:(NSArray *)array
                           completion:(void (^) (NSInteger index))completion
{
    UIAlertController * alertController = [UIAlertController new];
    
    for (int i=0; i<array.count; i++) {
        UIAlertAction * alertA = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completion ? completion(i) : nil;
        }];
        [alertController addAction:alertA];
    }
    
    UIAlertAction * alertC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertC];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
    
}
#endif

#pragma mark - 对alert做进一步封装
-(void)showAlertMessage:(NSString *)message oneText:(NSString *)one twoText:(NSString *)two completion:(void(^)(NSInteger index))completion
{
    if (kCurrentVersion >= 8.0) {
        [self showAlertController:UIAlertControllerStyleAlert title:nil message:message oneText:one twoText:two completion:^(NSInteger index) {
            completion ? completion(index) : nil;
        }];
    }
    else {
        [self showAlertView:message cancelText:one otherText:two completion:^(NSUInteger index) {
            completion ? completion(index) : nil;
        }];
    }
}

-(void)showAlertWithTitle:(NSString *)title Message:(NSString *)message oneText:(NSString *)one twoText:(NSString *)two completion:(void(^)(NSInteger index))completion
{
    if (kCurrentVersion >= 8.0) {
        [self showAlertController:UIAlertControllerStyleAlert title:title message:message oneText:one twoText:two completion:^(NSInteger index) {
            completion ? completion(index) : nil;
        }];
    }
    else {
        [self showAlertView:message cancelText:one otherText:two completion:^(NSUInteger index) {
            completion ? completion(index) : nil;
        }];
    }
}


#pragma mark - showActionSheet
-(void)showActionSheet:(NSString *)one twoText:(NSString *)two completion:(void(^)(NSInteger index))completion
{
    if (kCurrentVersion >= 8.0) {
        [self showAlertControllerStyleSheet:one twoText:two completion:^(NSInteger index) {
            completion ? completion(index) : nil;
        }];
    }
    else {
        [self showAlertActionSheet:one twoText:two completion:^(NSUInteger index) {
            completion ? completion(index) : nil;
        }];
    }
}

#pragma mark - showActionSheets
-(void)showActionSheets:(NSArray *)array completion:(void(^)(NSInteger index))completion
{
    if (kCurrentVersion >= 8.0) {
        [self showAlertControllerStyleSheets:array completion:^(NSInteger index) {
            completion ? completion(index) : nil;
        }];
    }
    else {
        [self showAlertActionSheets:array completion:^(NSUInteger index) {
            completion ? completion(index) : nil;
        }];
    }
}

@end
