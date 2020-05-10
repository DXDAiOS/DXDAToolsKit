//
//  DXDADefaultBtn.m
//  NewApp3.0
//
//  Created by Erowin on 16/11/4.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import "DXDADefaultBtn.h"

@implementation DXDADefaultBtn

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
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"导航背景"]];
//    self.layer.borderColor = DXDA_DefaultColor.CGColor;
    
    self.theme_backgroundColor = globalDefaultColorPicker;
    self.layer.theme_borderColor = globalCGColorPicker;
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
