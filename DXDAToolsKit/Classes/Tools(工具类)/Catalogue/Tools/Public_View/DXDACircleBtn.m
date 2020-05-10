//
//  DXDACircleBtn.m
//  NewApp3.0
//
//  Created by Erowin on 16/11/15.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "DXDACircleBtn.h"

@implementation DXDACircleBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setsubView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        [self setsubView];
    }
    return self;
}

-(void)setsubView
{
    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor colorWithRed:235.0/255.0f green:81.0/255.0f  blue:43.0/255.0f  alpha:1].CGColor;
    self.layer.theme_borderColor = globalCGColorPicker; //使用主题池的颜色，方便更换主题
    [self theme_setTitleColor:globalDefaultColorPicker forState:UIControlStateNormal];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
