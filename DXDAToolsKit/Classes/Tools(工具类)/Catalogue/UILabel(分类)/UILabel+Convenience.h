//
//  UILabel+Convenience.h
//  NewApp3.0
//
//  Created by DXDA on 2017/3/15.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Convenience)

+(UILabel *)createWithLeft:(CGRect)frame
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                      font:(NSInteger)font;

+(UILabel *)createWithRight:(CGRect)frame
                      title:(NSString *)title
                 titleColor:(UIColor *)titleColor
                       font:(NSInteger)font;

+(UILabel *)createWithCenter:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
                        font:(NSInteger)font;

@end
