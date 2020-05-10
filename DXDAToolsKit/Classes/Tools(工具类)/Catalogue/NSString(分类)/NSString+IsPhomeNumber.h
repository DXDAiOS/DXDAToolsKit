//
//  NSString+IsPhomeNumber.h
//  RxdaApp
//
//  Created by Erowin on 16/9/7.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IsPhomeNumber)
/**
 *  判断手机号码是否正确
 */
- (BOOL)isMobileNumber;
/**
 *  判断银行账号是否正确
 */
+ (BOOL) checkCardNo:(NSString*)cardNo;
/**
 *  判断身份证是否正确
 */
- (BOOL)checkIdentityCardNo;
/**
 *  判断邮箱是否正确
 */
+ (BOOL)isValidateEmail:(NSString *)email;
@end
