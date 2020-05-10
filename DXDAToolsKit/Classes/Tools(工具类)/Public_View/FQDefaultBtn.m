//
//  FQDefaultBtn.m
//  RxdaApp
//
//  Created by Erowin on 16/9/20.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "FQDefaultBtn.h"

@implementation FQDefaultBtn

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        [self setType];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setType];
    }
    return self;
}
-(void)setType
{
//    self.backgroundColor = [UIColor colorWithRed:235/255.f green:82/255.f blue:44/255.f alpha:1];
    self.theme_backgroundColor = globalDefaultColorPicker;

    
    self.frame = CGRectMake(10, SCREEN_HEIGHT - kNavgationAndFooderHeight - 50, SCREEN_WIDTH - 20, 40);
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
