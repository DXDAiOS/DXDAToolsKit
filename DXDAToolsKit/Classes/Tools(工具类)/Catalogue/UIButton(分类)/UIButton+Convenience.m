//
//  UIButton+Convenience.m
//  NewApp3.0
//
//  Created by DXDA on 2017/3/15.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UIButton+Convenience.h"

@implementation UIButton (Convenience)

+(UIButton *)createTempBtn:(CGRect)frame target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UIButton *)createPopBtn:(CGRect)frame title:(NSString *)title font:(CGFloat)font target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+(UIButton *)createBottom:(CGRect)frame
                    title:(NSString *)title
                     font:(NSInteger)font
                   target:(id)target
                   action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
