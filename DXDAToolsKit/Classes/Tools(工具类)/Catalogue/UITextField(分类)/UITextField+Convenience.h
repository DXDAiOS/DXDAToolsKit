//
//  UITextField+Convenience.h
//  NewApp3.0
//
//  Created by DXDA on 2017/3/15.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Convenience)

+(UITextField *)createWithRight:(CGRect)frame
                    placeHolder:(NSString *)placeHolder
                   keyboardType:(UIKeyboardType)keyboardType
                       fontSize:(CGFloat)font;

+(UITextField *)createWithLeft:(CGRect)frame
                   placeHolder:(NSString *)placeHolder
                  keyboardType:(UIKeyboardType)keyboardType
                      fontSize:(CGFloat)font;

+(UITextField *)createWithCenter:(CGRect)frame
                     placeHolder:(NSString *)placeHolder
                    keyboardType:(UIKeyboardType)keyboardType
                        fontSize:(CGFloat)font;

@end
