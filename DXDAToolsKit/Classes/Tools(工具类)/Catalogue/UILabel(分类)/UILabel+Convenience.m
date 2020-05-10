//
//  UILabel+Convenience.m
//  NewApp3.0
//
//  Created by DXDA on 2017/3/15.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UILabel+Convenience.h"

@implementation UILabel (Convenience)

+(UILabel *)createWithLeft:(CGRect)frame
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                      font:(NSInteger)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

+(UILabel *)createWithRight:(CGRect)frame
                      title:(NSString *)title
                 titleColor:(UIColor *)titleColor
                       font:(NSInteger)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

+(UILabel *)createWithCenter:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
                        font:(NSInteger)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

@end
