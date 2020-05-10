//
//  UITextField+Convenience.m
//  NewApp3.0
//
//  Created by DXDA on 2017/3/15.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UITextField+Convenience.h"
#import "DXDANormalTools.h"
@implementation UITextField (Convenience)

+(UITextField *)createWithRight:(CGRect)frame
                    placeHolder:(NSString *)placeHolder
                   keyboardType:(UIKeyboardType)keyboardType
                       fontSize:(CGFloat)font
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeHolder;
    textField.tintColor = DXDA_DefaultColor;
    textField.keyboardType = keyboardType;
    textField.textColor = [UIColor blackColor];
    textField.textAlignment = NSTextAlignmentRight;
    textField.font = [UIFont systemFontOfSize:font];
    return textField;
}


+(UITextField *)createWithLeft:(CGRect)frame
                   placeHolder:(NSString *)placeHolder
                  keyboardType:(UIKeyboardType)keyboardType
                      fontSize:(CGFloat)font
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeHolder;
//    textField.tintColor = DXDA_DefaultColor;
    textField.keyboardType = keyboardType;
    textField.textColor = [UIColor blackColor];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:font];
    return textField;
}

+(UITextField *)createWithCenter:(CGRect)frame
                     placeHolder:(NSString *)placeHolder
                    keyboardType:(UIKeyboardType)keyboardType
                        fontSize:(CGFloat)font
{
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeHolder;
    //    textField.tintColor = DXDA_DefaultColor;
    textField.keyboardType = keyboardType;
    textField.textColor = [UIColor blackColor];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.font = [UIFont systemFontOfSize:font];
    return textField;
}

@end
