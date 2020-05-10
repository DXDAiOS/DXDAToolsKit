//
//  UIButton+Convenience.h
//  NewApp3.0
//
//  Created by DXDA on 2017/3/15.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Convenience)

+(UIButton *)createTempBtn:(CGRect)frame target:(id)target action:(SEL)action;

+(UIButton *)createPopBtn:(CGRect)frame title:(NSString *)title font:(CGFloat)font target:(id)target action:(SEL)action;

+(UIButton *)createBottom:(CGRect)frame
                    title:(NSString *)title
                     font:(NSInteger)font
                   target:(id)target
                   action:(SEL)action;

@end
