//
//  UIView+DXDAView.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/10/25.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UIView+DXDAView.h"

@implementation UIView (DXDAView)


+ (UIView *)textfRightView:(NSString *)text
{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
//    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 44/2-4.5, 15, 10)];
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 44)];
    rightLabel.text = text;
//    rightLabel.textColor = DXDA_G_textColor;
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.font = [UIFont systemFontOfSize:15];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:rightLabel];
    return rightView;
}

@end
